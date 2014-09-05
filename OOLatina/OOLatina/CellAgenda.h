//
//  CellAgenda.h
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Utility.h"

@class CellAgenda;

@protocol CellAgendaDelegate <NSObject>

- (void)tappedCellAgenda:(Event*) event;

@end

@interface CellAgenda : UIView
{
    Event *mEvent;
    UILabel *titleLabel;
    UIView *separator;
//    UILabel *lieuLabel;
    UILabel *titleDayLetter;
    UILabel *titleDay;
    UIImageView *thumbnail;
    UIActivityIndicatorView *mLoading;
    UIView *titleBackground;
}

@property (nonatomic, weak) id<CellAgendaDelegate> delegate;
- (void)addEvent:(Event *)_event;

@end
