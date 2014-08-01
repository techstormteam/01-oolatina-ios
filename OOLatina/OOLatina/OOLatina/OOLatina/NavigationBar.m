//
//  NavigationBar.m
//  OOLatina
//
//  Created by Jérôme Laurent on 11/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        currentFontName = @"Helvetica";
        
        CGRect initialFrame = frame;
        initialFrame.size.height = 60;
        frame = initialFrame;
        
        BackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:BackgroundImage];
        
        TitleBar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        TitleBar.textAlignment = NSTextAlignmentCenter;
        [self addSubview:TitleBar];
    }
    return self;
}

- (void)SetBackgroundImage:(NSString *)filename
{
    BackgroundImage.image = [UIImage imageNamed:filename];
}

- (void)SetTitle:(NSString *)title
{
    TitleBar.text = title;
}

- (void)SetTitleColor:(CGRect)rgbaColor
{
    TitleBar.textColor = [UIColor colorWithRed:255/rgbaColor.origin.x green:255/rgbaColor.origin.y blue:255/rgbaColor.size.width alpha:255/rgbaColor.size.height];
}

- (void)SetTitleFontSize:(int)size
{
    TitleBar.font = [UIFont fontWithName:currentFontName size:size];
}

@end
