//
//  AgendaDayCell.h
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAgenda.h"

@class AgendaDayCell;

@protocol AgendaDayCellDelegate <NSObject>

- (void)tappedCellAgenda:(Event*) event;

@end

@interface AgendaDayCell : UIView<CellAgendaDelegate>
{
    UILabel *titleLabel;
    int yPos;
}

@property (nonatomic, weak) id<AgendaDayCellDelegate> delegate;
- (void)addMutableEvent:(NSMutableArray *)eventMutable;

@end
