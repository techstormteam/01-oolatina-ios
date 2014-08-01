//
//  UIScrollLinear.h
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Radio.h"

@protocol UIScrollLinearDelegate <NSObject>
- (void)changeRadio:(int)radioSelect;
@end

@interface UIScrollLinear : UIView <RadioDelegate>
{
    CGFloat mEcart;
    UIScrollView *mScrollView;
    NSMutableArray *mScrollArray;
}

@property (nonatomic,assign) id<UIScrollLinearDelegate> delegate;

- (void)addView:(UIView *)nView;

@end
