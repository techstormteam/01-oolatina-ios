//
//  FirstGuideView.h
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "ViewController.h"

@interface FirstGuideView : UIViewController {
    UIViewController *parent;
}

@property (nonatomic, strong) IBOutlet UIView *viewInside;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)btnNextTapped:(id)sender;

- (void)setParent:(ViewController*)parentView;

@end
