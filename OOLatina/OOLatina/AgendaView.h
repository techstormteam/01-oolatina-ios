//
//  AgendaView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AgendaCell.h"
#import "AgendaScroll.h"
#import "CKCalendarView.h"
#import "DropDownListView.h"
#import "ArrayDropDown.h"

@interface AgendaView : UIView <UITextFieldDelegate, CKCalendarDelegate, kDropDownListViewDelegate>
{
    UIImageView *background;
    UITableView *mTableView;
    NSMutableArray *eventArray;
    NSMutableArray *genreArray;
    NSMutableArray *musicArray;
    NSMutableArray *villeArray;
    UISearchBar *mSearchBar;
    AgendaScroll *mAgendaScroll;
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
    
    DropDownListView *mDropDown;
    CKCalendarView *mCalendarView;
    UIActivityIndicatorView *mLoading;
    int dropSelected;
    
    NSString *villeSelected;
    NSString *day;
    NSString *month;
    NSString *year;
    NSString *musicArrayid;
    NSString *genreArrayid;
}

- (void)loadEvent;
- (void)showSearch;
- (void)hideSearch;
- (void)DropDownListViewDidCancel;

@end
