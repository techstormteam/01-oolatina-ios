//
//  NewsView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsScroller.h"
#import "NewsCell.h"
#import "News.h"
#import "Utility.h"

@protocol NewsViewDelegate <NSObject>
- (void)showPageFeed:(NSString *)url;
@end

@interface NewsView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    int newsCount;
    int heightOfCell;
    NSMutableArray *newsObjects;
    NewsScroller *mNewsScroller;
    UIImageView *background;
    dispatch_queue_t myQueue;
    
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *currentTitle,*currentSummary,*currentImageLink,*currentDescription;
}

@property (nonatomic,assign) id<NewsViewDelegate> delegate;

@end
