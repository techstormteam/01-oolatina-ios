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

@interface AgendaScroll : UIView
{
    UIScrollView *mScrollView;
    NSMutableArray *mEventArray;
    NSMutableArray *mEventCell;
    int yPos;
}

- (void)addEvent:(Event *)_event;
- (void)loadEvent;

- (void)removeAllEvent;

@end
