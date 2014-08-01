//
//  ImageElement.m
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "ImageElement.h"

@implementation ImageElement

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];
        
        bandeau = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-130, frame.size.height-30, 130, 20)];
        bandeau.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:39.0/255.0 blue:116.0/255.0 alpha:0.90];
        [self addSubview:bandeau];
        
        labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bandeau.frame.size.width, bandeau.frame.size.height)];
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        labelView.textColor = [UIColor whiteColor];
        [bandeau addSubview:labelView];
        
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:background];
    }
    return self;
}

- (void)setImageView:(NSString *)_image
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if([filemanager fileExistsAtPath:[[NSBundle mainBundle] pathForResource:_image ofType:nil]])
    {
        imageView.image = [UIImage imageNamed:_image];
    }
    else
    {
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_image]];
        imageView.image = [UIImage imageWithData:data];
    }
}

- (void)setTextView:(NSString *)_text
{
    labelView.text = _text;
}

- (void)setIdElement:(NSString *)_idElement
{
    idElement = _idElement;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self delegate] selectImage:idElement];
    background.backgroundColor = [UIColor clearColor];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    background.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

@end
