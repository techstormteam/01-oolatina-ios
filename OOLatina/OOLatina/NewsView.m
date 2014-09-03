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


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
    
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentImageLink = [[NSMutableString alloc] init];
        currentDescription = [[NSMutableString alloc] init];
	}
}

//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
//    
//	if ([elementName isEqualToString:@"item"]) {
//		// save values to an item, then store that item into the array...
//		[item setObject:currentTitle forKey:@"title"];
//		[item setObject:currentImageLink forKey:@"link"];
//		
//        // Hack pour ajouter l'image du feed du flux rss;
//        NSArray *array = [currentSummary componentsSeparatedByString:@"\""];
//        currentSummary = [array objectAtIndex:5];
//        
//        [item setObject:currentSummary forKey:@"summary"];
////        [mNewsScroller addElement:currentSummary andTitle:currentTitle andId:currentImageLink];
//	}
//}
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//	//NSLog(@"found characters: %@", string);
//	// save the characters for the current item...
//	if ([currentElement isEqualToString:@"title"]) {
//		[currentTitle appendString:string];
//	} else if ([currentElement isEqualToString:@"link"]) {
//		[currentImageLink appendString:string];
//	} else if ([currentElement isEqualToString:@"description"]) {
//		[currentSummary appendString:string];
//	}
//}

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
        if ([news getTitle] == nil) {
            cell.mTitle.text = NSLocalizedString(@"no_title", nil);
        } else {
            cell.mTitle.text = [news getTitle];
        }
        if ([news getDescription] == nil) {
            cell.mDescription.text = NSLocalizedString(@"no_description", nil);
        } else {
            cell.mDescription.text = [news getDescription];
        }
        UIImage *image = [Utility getImageFromURL:[news getImage]];
        cell.mImage.image = [Utility imageWithImage:image scaledToSize:fr.size];
        newsCount++;
    }
    
    return cell;
    
}



 #pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightOfCell;
}


@end
