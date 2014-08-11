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
#import "SCUtils.h"

@interface AgendaWholeView : UIViewController <UIScrollViewDelegate>
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
    
    NSString *villeSelected;
    NSString *day;
    NSString *month;
    NSString *year;
    NSString *musicArrayid;
    NSString *genreArrayid;
    
    UIView *popupView;
    UITextField *calendarField;
    UITextField *searchField;
    UITextField *villeField;
    UIButton *dropdownGenre;
    UIButton *dropdownMusic;
    UITextField *dropdownVille;
    UITextField *genreField;
    UITextField *musicField;
    UIView *mbackPopup;
    UIButton *closeButton;
    
    NSMutableArray *eventArray;
    NSMutableArray *genreArray;
    NSMutableArray *musicArray;
    NSMutableArray *villeArray;
    
    DropDownListView *mDropDown;
    CKCalendarView *mCalendarView;
    UIActivityIndicatorView *mLoading;
    int dropSelected;
}



@property (retain, nonatomic) IBOutlet UIButton *agendaButton;
@property (retain, nonatomic) IBOutlet UIButton *arroundMeButton;
@property (retain, nonatomic) IBOutlet UIButton *mapButton;
@property (retain, nonatomic) IBOutlet UILabel *slidLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *nibScrollView;

- (void) showSearch;
- (void) loadEvent;
- (void) hideSearch;

@end
