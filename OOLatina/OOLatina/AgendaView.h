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
#import "iToast.h"
#import "MBProgressHUD.h"

@class AgendaView;

@protocol AgendaViewDelegate <NSObject>

- (void)tappedCellAgenda:(Event*) event;

@end

@interface AgendaView : UIView <CLLocationManagerDelegate, AgendaScrollDelegate>
{
    UIImageView *background;
    AgendaScroll *mAgendaScroll;
    UILabel *mNotFound;
    
    NSMutableArray *eventArray;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}


@property (nonatomic, weak) id<AgendaViewDelegate> delegate;
@property (nonatomic, strong) MBProgressHUD   * theHud;
- (void)gettingLocation;
- (bool)isInside:(Event *)ev radius:(CGFloat)rad;
- (void)loadEvent:(NSMutableArray *) eventArray;
- (void)loadEventArroundMe:(NSMutableArray *) eventArray;


@end
