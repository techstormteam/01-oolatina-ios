//
//  PhotoView.h
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCustomCell.h"
#import "SCUtils.h"
#import "PhotoEvent.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "Utility.h"
#import "ArrayDropDown.h"
#import "DropDownListView.h"
#import "CKCalendarView.h"

@interface PhotoView : UIView <GMGridViewDataSource, PhotoCustomCellDelegate, UITextFieldDelegate, kDropDownListViewDelegate, CKCalendarDelegate> {
    
    NSMutableArray *photoEvents;
    NSMutableArray *photos;
    NSMutableArray *sectionSizes;
    UIImageView *background;
    UIView *backgroundPlayer;
    PhotoPreviewView *viePhotoPreview;
    
    UIScrollView *scrollView;
    __gm_weak GMGridView *_gmGridView2;
    
    
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

- (void)showPhotoList;
- (void)showSearch;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) CGFloat numberOfImageInRow;

@end
