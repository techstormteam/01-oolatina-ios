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
    UISearchBar *mSearchBar;
    AgendaScroll *mAgendaScroll;
    
    NSMutableArray *eventArray;
    
}

- (void)loadEvent:(NSMutableArray *) eventArray;


@end
