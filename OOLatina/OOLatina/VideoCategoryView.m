//
//  VideoCategoryView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "VideoCategoryView.h"
#import "LBYouTubePlayerViewController.h"
#import "VideoTableViewCell.h"
#import "Video.h"
#import "SCUtils.h"

@implementation VideoCategoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        videoArray = [[NSMutableArray alloc] init];
        mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 160)];
        mWebView.backgroundColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeFinished:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
        [self addSubview:mWebView];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 160, frame.size.width, 2)];
        separator.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:38.0/255.0 blue:116.0/255 alpha:1.0];
        [self addSubview:separator];
        
        if([SCUtils isPhone5])
        {
            mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 162, frame.size.width, frame.size.height-210)];
        }
        else
        {
            mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 162, frame.size.width, frame.size.height-210)];
        }
        [mTableView setBackgroundView:nil];
        [mTableView setBackgroundColor:[UIColor clearColor]];
        mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mTableView.delegate = self;
        mTableView.dataSource = self;
        [self addSubview:mTableView];
    }
    return self;
}

-(void)youTubeStarted:(NSNotification *)notification{
    // Entered Fullscreen code goes here..
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = YES;
}

-(void)youTubeFinished:(NSNotification *)notification{
    // Left fullscreen code goes here...
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = NO;
    
    //CODE BELOW FORCES APP BACK TO PORTRAIT ORIENTATION ONCE YOU LEAVE VIDEO.
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    //present/dismiss viewcontroller in order to activate rotating.
    UIViewController *mVC = [[UIViewController alloc] init];
//    [self presentModalViewController:mVC animated:NO];
//    [self dismissModalViewControllerAnimated:NO];
}

- (void)loadCategory:(NSString *)idcategory
{
    if([SCUtils isNetworkAvailable])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_VIDEO_CATEGORIE&idcategory=%@",idcategory]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
            NSDictionary *dict = [results objectAtIndex:x];
            Video *mVideo = [[Video alloc] init];
            [mVideo setVideoId:[dict objectForKey:@"youtube"]];
            [mVideo setVideoTitle:[dict objectForKey:@"title"]];
            [mVideo setVideoThumbnail:[dict objectForKey:@"thumbnail"]];
            [videoArray addObject:mVideo];
        }
    
        if(videoArray.count != 0)
        {
            Video *mVideo = (Video *)[videoArray objectAtIndex:0];
            [self playVideoWithId:[mVideo getVideoId]];
        }
    
        [mTableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)playVideoWithId:(NSString *)videoId
{
    NSString *youTubeVideoHTML = @"<html>\
    <body style=\"margin:0;background-color:black;\">\
    <iframe class=\"youtube-player\" type=\"text/html\" width=\"%0.0f\" height=\"%0.0f\" src=\"http://www.youtube.com/embed/%@\" frameborder=\"0\">\
    </iframe>\
    </body>\
    </html>";
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, mWebView.frame.size.width, mWebView.frame.size.height, videoId];

    [mWebView loadHTMLString:html baseURL:nil];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor colorWithRed:221.0/255.0 green:38.0/255.0 blue:116.0/255.0 alpha:1.0] ForCell:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    int modulo = indexPath.row % 2;
    NSLog(@"modulo : %d",modulo);
    if (modulo == 1)
    {
        [self setCellColor:[UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7] ForCell:cell];
    }
    else
    {
        [self setCellColor:[UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7] ForCell:cell];
    }
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell
{
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [videoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int modulo = indexPath.row % 2;
    NSLog(@"modulo : %d",modulo);
    if (modulo == 1)
    {
        [self setCellColor:[UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7] ForCell:cell];
    }
    else
    {
        [self setCellColor:[UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7] ForCell:cell];
    }

    Video *mVideo = (Video *)[videoArray objectAtIndex:indexPath.row];
    [cell loadThumbnail:[mVideo getVideoThumbnail]];
    [cell setVideoTitle:[mVideo getTitle]];
    //cell.textLabel.text = [mVideo getTitle];
    //cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Video *mVideo = (Video *)[videoArray objectAtIndex:indexPath.row];
    [self playVideoWithId:[mVideo getVideoId]];
    //VideoCategory *mVideoCategory = (VideoCategory *)[arrayVideoCategory objectAtIndex:indexPath.row];
    //[[self delegate] showCategoryVideo:[mVideoCategory getCategoryId]];
}


@end
