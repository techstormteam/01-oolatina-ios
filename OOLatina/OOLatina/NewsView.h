//
//  NewsView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDoubleScroll.h"

@protocol NewsViewDelegate <NSObject>
- (void)showPageFeed:(NSString *)url;
@end

@interface NewsView : UIView <UIDoubleScrollDelegate, NSXMLParserDelegate>
{
    UIDoubleScroll *mDoubleScroll;
    UIImageView *background;
    NSMutableArray *arrayRSS;
    NSMutableArray *stories;
    NSXMLParser *rssParser;
    
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *currentTitle,*currentDate,*currentSummary,*currentLink,*currentDescription;
}

@property (nonatomic,assign) id<NewsViewDelegate> delegate;

@end
