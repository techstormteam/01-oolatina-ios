//
//  AgendaView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Event.h"
#import "AgendaCell.h"
#import "AgendaScroll.h"
#import "CKCalendarView.h"
#import "DropDownListView.h"
#import "ArrayDropDown.h"

@interface AgendaView : UIView <CLLocationManagerDelegate>
{
    UIImageView *background;
    AgendaScroll *mAgendaScroll;
    
    NSMutableArray *eventArray;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

- (bool)isInside:(Event *)event: (CGFloat)radius;
- (void)loadEvent:(NSMutableArray *) eventArray;


@end
