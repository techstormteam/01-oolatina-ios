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
        arrayRSS = [[NSMutableArray alloc] init];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        mDoubleScroll = [[UIDoubleScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50)];
        mDoubleScroll.delegate = self;
        mDoubleScroll.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:mDoubleScroll];
        
        [self parseXMLFileAtURL:@"http://united-kingdom.oolatina.com/feed/"];
    }
    return self;
}

- (void)parseXMLFileAtURL:(NSString *)URL
{
    if([SCUtils isNetworkAvailable])
    {
        stories = [[NSMutableArray alloc] init];
        NSURL *xmlURL = [NSURL URLWithString:URL];
        rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        rssParser.delegate = self;
        [rssParser setShouldProcessNamespaces:NO];
        [rssParser setShouldReportNamespacePrefixes:NO];
        [rssParser setShouldResolveExternalEntities:NO];
    
        [rssParser parse];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"found file and started parsing");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
    
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
    
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
        currentDescription = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		
        // Hack pour ajouter l'image du feed du flux rss;
        NSArray *array = [currentSummary componentsSeparatedByString:@"\""];
        currentSummary = [array objectAtIndex:5];
        
        [item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"pubDate"];
        
        [mDoubleScroll addElement:currentSummary andTitle:currentTitle andId:currentLink];
		//[stories addObject:[item copy]];
		//NSLog(@"adding story: %@", currentTitle);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
}

- (void)selectVideoCategory:(NSString *)idElement
{
    NSString *urlFeed = [idElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [[self delegate] showPageFeed:urlFeed];
    //NSLog(@"Launch url : %@",urlFeed);
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlFeed]];
}


@end
