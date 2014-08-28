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
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        mNewsScroller = [[NewsScroller alloc] initWithNibName:@"NewsScroller" bundle:nil];
        mNewsScroller.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-50);
        mNewsScroller.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:mNewsScroller.view];
        
//        [self parseXMLFileAtURL:@"http://studio.shua-creation.com/rss/rss.php"];
    }
    return self;
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



@end
