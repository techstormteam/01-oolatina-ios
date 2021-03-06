//
//  AgendaScroll.h
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AgendaDayCell.h"

@class AgendaScroll;

@protocol AgendaScrollDelegate <NSObject>

- (void)tappedCellAgenda:(Event*) event;

@end

@interface AgendaScroll : UIView<UIScrollViewDelegate, AgendaDayCellDelegate>
{
    UIScrollView *mScrollView;
    NSMutableArray *mEventArray;
    NSMutableArray *mEventCell;
    int yPos;
    
    dispatch_queue_t myQueue;
    bool inProgress;
    int currentEventCount;
}

@property (nonatomic, weak) id<AgendaDayCellDelegate> delegate;
- (void)setCurrentEventCount:(int)currentCount;
- (void)addEvent:(Event *)_event;
- (void)loadEventPart:(int)nextAmount;
- (void)removeAllEvent;

@end
