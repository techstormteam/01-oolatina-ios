//
//  CellAgenda.h
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CellAgenda : UIView
{
    UILabel *titleLabel;
    UIView *separator;
    UILabel *lieuLabel;
    UILabel *titleDayLetter;
    UILabel *titleDay;
    UIImageView *thumbnail;
    UIActivityIndicatorView *mLoading;
}

- (void)addEvent:(Event *)_event;

@end
