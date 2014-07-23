//
//  Radio.m
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Radio.h"

@implementation Radio

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageRadio = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageRadio];
        
        borderSelected = [[UIView alloc] initWithFrame:CGRectMake(0, -5, frame.size.width, 5)];
        borderSelected.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:38.0/255.0 blue:118.0/255.0 alpha:1.0];
        [self addSubview:borderSelected];
        borderSelected.hidden = YES;
        
        isSelected = NO;
    }
    return self;
}

- (void)setImage:(NSString *)_image
{
    imageRadio.image = [UIImage imageNamed:_image];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isSelected = YES;
    [self updateSelected];
    [[self delegate] changeRadio:self.tag];
}

- (void)setSelected:(BOOL)_select
{
    isSelected = _select;
    [self updateSelected];
}

- (void)updateSelected
{
    if(isSelected)
    {
        borderSelected.hidden = NO;
    }
    else
    {
        borderSelected.hidden = YES;
    }
}

@end
