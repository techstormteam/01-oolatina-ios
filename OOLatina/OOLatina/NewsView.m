//
//  NewsView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "NewsView.h"
#import "ArtistTableViewCell.h"
#import "SCUtils.h"

@implementation NewsView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        heightOfCell = 200;
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
//        [self addSubview:background];
        
        mNewsScroller = [[NewsScroller alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        mNewsScroller.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        mNewsScroller.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        mNewsScroller.backgroundView = background;
        [self addSubview:mNewsScroller];
        [self loadNewsEvent];
        mNewsScroller.delegate = self;
        mNewsScroller.dataSource = self;
        myQueue = dispatch_queue_create("PhotoDownload",NULL);
    }
    return self;
}

- (void)loadNewsEvent {
    
    if([SCUtils isNetworkAvailable])
    {
        newsCount = 0;
        newsObjects = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://studio.shua-creation.com/rss/rss.php"]];
        NSLog(@"URL : %@",url);
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *results = object;
        for (int x=0; x<results.count; x++)
        {
            NSDictionary *mDico = [results objectAtIndex:x];
            News *newsObj = [[News alloc] init];
            [newsObj setTitle:[mDico objectForKey:@"title"]];
            [newsObj setDescription:[mDico objectForKey:@"description"]];
            [newsObj setImage:[mDico objectForKey:@"image"]];
            [newsObjects addObject:newsObj];
        }
        
        // Load table view
        
    }
}


- (void)showNewsDetail:(News*) nNews
{
    if (newsDetail == nil) {
        newsDetail = [[NewsDetail alloc] initWithFrame:CGRectMake(0, 0, 320, 658)];
        [newsDetail setNews:nNews];
        [self addSubview:newsDetail];
    } else {
        [newsDetail setNews:nNews];
        [self bringSubviewToFront:newsDetail];
    }
    
}



#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    // Return the number of sections.
    return [newsObjects count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    // Return the number of rows in the section.
    return 1;
}





- (NewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *identifier = @"NewsCell";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell == nil && newsCount < [newsObjects count]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = (NewsCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect fr = CGRectMake(0, 0, tableView.frame.size.width, heightOfCell);
        cell.frame = fr;
        cell.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        News *news = [newsObjects objectAtIndex:newsCount];
        [cell setNews:news imageScaleSize:fr.size];
        cell.delegate = self;

        
        newsCount++;
    }
    
    return cell;
    
}

- (void)tappedNewsCell:(News*) news
{
    [self showNewsDetail:news];
}

 #pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightOfCell;
}


@end
