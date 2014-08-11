//
//  AgendaWholeView.h
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaView.h"
#import "AgendaMapView.h"

@interface AgendaWholeView : UIViewController < UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{

    NSArray *couponArry;
    NSArray *groupbuyArry;
    
    AgendaView *agendaView;
    AgendaView *arroundMeView;
    AgendaMapView *agendaMapView;
    
    UITableView *couponTableView;
    UITableView *groupbuyTableView;
    
	UIPageControl *pageControl;
    int currentPage;
    BOOL pageControlUsed;
}

@property (retain, nonatomic) IBOutlet UIButton *agendaButton;
@property (retain, nonatomic) IBOutlet UIButton *arroundMeButton;
@property (retain, nonatomic) IBOutlet UIButton *mapButton;
@property (retain, nonatomic) IBOutlet UILabel *slidLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *nibScrollView;

- (void) showSearch;
- (void) loadEvent;

@end
