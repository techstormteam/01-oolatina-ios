//
//  FirstGuideView.h
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstGuideView.h"

@class FirstGuideView;

@protocol FirstGuideViewDelegate <NSObject>

- (void)tappedNext;

@end

@interface FirstGuideView : UIViewController {
    UIViewController *parent;
}

@property (nonatomic, weak) id<FirstGuideViewDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIView *viewInside;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)btnNextTapped:(id)sender;




@end
