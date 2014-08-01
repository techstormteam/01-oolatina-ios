//
//  UIDoubleScroll.m
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "UIDoubleScroll.h"

@implementation UIDoubleScroll

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scrollArray = [[NSMutableArray alloc] init];
        
        mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:mScrollView];
        
        xPos = 0;
        yPos = 0;
    }
    return self;
}

- (void)addElement:(NSString *)image andTitle:(NSString *)title andId:(NSString *)_idElement
{
    ImageElement *mElement = [[ImageElement alloc] initWithFrame:CGRectMake(xPos, yPos, 160, 120)];
    xPos = xPos + 160;
    
    if(xPos >= 320)
    {
        xPos = 0;
        yPos = yPos+120;
    }
    
    [mElement setImageView:image];
    [mElement setTextView:title];
    [mElement setIdElement:_idElement];
    mElement.delegate = self;
    
    [mScrollView addSubview:mElement];
    [mScrollView setContentSize:CGSizeMake(self.frame.size.width, (((scrollArray.count+2)*120)/2))];
    
    [scrollArray addObject:mElement];
}

- (void)selectImage:(NSString *)idelement
{
    [[self delegate] selectVideoCategory:idelement];
}

@end
