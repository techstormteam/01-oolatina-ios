//
//  AlbumView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AlbumView.h"
#import "SCUtils.h"

@implementation AlbumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        UIView *grayBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        grayBack.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:grayBack];
        
        jaquette = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 160)];
        jaquette.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:jaquette];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 160-60, frame.size.width-19, 30)];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:38.0/255.0 blue:117.0/255.0 alpha:0.7];

        [self addSubview:titleLabel];
        
        titleAlbum = [[UILabel alloc] initWithFrame:CGRectMake(19, 160-30, frame.size.width-19, 25)];
        titleAlbum.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        titleAlbum.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.7];
        titleAlbum.textColor = [UIColor whiteColor];
        [self addSubview:titleAlbum];
        
        if([SCUtils isPhone5])
        {
            mTableViewListMusic = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, frame.size.width, frame.size.height-220)];
        }
        else
        {
            mTableViewListMusic = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, frame.size.width, frame.size.height-220)];
        }
        [mTableViewListMusic setBackgroundView:nil];
        [mTableViewListMusic setBackgroundColor:[UIColor clearColor]];
        mTableViewListMusic.separatorStyle = UITableViewCellSeparatorStyleNone;
        mTableViewListMusic.delegate = self;
        mTableViewListMusic.dataSource = self;
        [self addSubview:mTableViewListMusic];
        
        arrayMusic = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadAlbum:(NSString *)idAlbum
{
    NSString *jaquetteUrl;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.oolatina.com/webservice/oolatina_api.php?command=GET_ALL_MUSIC_ALBUM&idalbum=%@",idAlbum]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *results = object;
    for (int x=0; x<results.count; x++)
    {
        NSDictionary *dict = [results objectAtIndex:x];
        [self addMusic:[dict objectForKey:@"audio"] andTitle:[dict objectForKey:@"title"] andNumber:@"0"];
        [self setTitle:[dict objectForKey:@"artistname"]];
        [self setTitleAlbum:[dict objectForKey:@"albumname"]];
        jaquetteUrl = [dict objectForKey:@"coveralbum"];
    }
    
    [self loadJaquette:jaquetteUrl];
}

- (void)loadJaquette:(NSString *)url
{
    NSURL *_url = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:_url];
    jaquette.image = [UIImage imageWithData:data];
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)setTitleAlbum:(NSString *)album
{
    titleAlbum.text = album;
}

- (void)addMusic:(NSString *)url andTitle:(NSString *)title andNumber:(NSString * )number
{
    MusicObject *mMusic = [[MusicObject alloc] init];
    [mMusic setTitleMusic:title];
    [mMusic setURLMusic:url];
    [mMusic setNumberMusic:number];
    [arrayMusic addObject:mMusic];
    [mTableViewListMusic reloadData];
}

// TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayMusic count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 39.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int modulo = indexPath.row % 2;
    NSLog(@"modulo : %d",modulo);
    if (modulo == 1)
    {
        cell.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7];
    }
    else
    {
        cell.backgroundColor =  [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7];
    }
    
    cell.tag = indexPath.row;
    MusicObject *mMusic = (MusicObject *)[arrayMusic objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setPlay:[mMusic getisPlaying]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[mMusic getTitleMusic]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)stopAllPlaying:(int)number
{
    for (int x=0; x<arrayMusic.count; x++)
    {
        if(x != number)
        {
            MusicObject *mMusic = (MusicObject *)[arrayMusic objectAtIndex:x];
            [mMusic stop];
        }
    }
    
    [mTableViewListMusic reloadData];
}

- (void)touchPlaying:(int)number
{
    [self stopAllPlaying:number];
    MusicObject *mMusic = (MusicObject *)[arrayMusic objectAtIndex:number];
    if([mMusic getisPlaying])
    {
        [mMusic stop];
    }
    else
    {
        [mMusic play];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
