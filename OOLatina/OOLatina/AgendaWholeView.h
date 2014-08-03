//
//  AgendaWholeView.h
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaWholeView : UIViewController < UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{

    NSArray *couponArry;
    NSArray *groupbuyArry;
    
    UITableView *couponTableView;
    UITableView *groupbuyTableView;
    
	UIPageControl *pageControl;
    int currentPage;
    BOOL pageControlUsed;
}

@property (strong, nonatomic) IBOutlet UIView *view;

@property (retain, nonatomic) IBOutlet UIButton *couponButton;
@property (retain, nonatomic) IBOutlet UIButton *groupbuyButton;
@property (retain, nonatomic) IBOutlet UILabel *slidLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *nibScrollView;

@end
