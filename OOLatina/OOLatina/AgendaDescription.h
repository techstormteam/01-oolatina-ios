//
//  AgendaDescription.h
//  OOLatina
//
//  Created by Macbook air on 9/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "AgendaMapView.h"

@interface AgendaDescription : UIView<UIScrollViewDelegate> {
    Event *mEvent;
    
    bool needLoadingDescription;
    bool needLoadingMap;
    
    UIPageControl *pageControl;
    int currentPage;
    BOOL pageControlUsed;
    
    UILabel *mDescriptionLabel;
    AgendaMapView *agendaMapView;
    
    UIImageView *background;
    UIView *backgroundPlayer;
}
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *descriptionButton;
@property (strong, nonatomic) IBOutlet UIScrollView *nibScrollView;
@property (strong, nonatomic) IBOutlet UILabel *slidLabel;

- (void)setEvent:(Event *)uEvent;

@end
