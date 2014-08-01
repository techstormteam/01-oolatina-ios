//
//  UIScrollLinear.m
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "UIScrollLinear.h"

@implementation UIScrollLinear

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mScrollArray = [[NSMutableArray alloc] init];
        
        mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:mScrollView];
        
        mEcart = 10;
    }
    return self;
}

- (void)addView:(Radio *)nView
{
    nView.frame = CGRectMake((mScrollArray.count * (nView.frame.size.width+mEcart)), self.frame.size.height-nView.frame.size.height, nView.frame.size.width, nView.frame.size.height);
    nView.delegate = self;
    [mScrollView addSubview:nView];
    [mScrollArray addObject:nView];
    
    mScrollView.contentSize = CGSizeMake(mScrollArray.count * (nView.frame.size.width+mEcart),mScrollView.frame.size.height);
}

- (void)changeRadio:(int)radioSelect
{
    [self deselectAllRadio:radioSelect];
    [[self delegate] changeRadio:radioSelect];
}

- (void)deselectAllRadio:(int)radioSelect
{
    for (int x=0; x<mScrollArray.count; x++)
    {
        Radio *mRadio = (Radio *)[mScrollArray objectAtIndex:x];
        if(mRadio.tag != radioSelect)
        {
            [mRadio setSelected:NO];
        }
    }
}

@end
