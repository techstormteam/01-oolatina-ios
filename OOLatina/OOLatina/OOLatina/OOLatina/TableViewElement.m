//
//  TableViewElement.m
//  OOLatina
//
//  Created by Jérôme Laurent on 12/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "TableViewElement.h"

@implementation TableViewElement

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        
        separator = [[UIView alloc] initWithFrame:CGRectMake(20, frame.size.height-separatorSize, frame.size.width-40, separatorSize)];
        separator.backgroundColor = [UIColor redColor];
        [self addSubview:separator];
        
        separatorSize = 1;
    }
    return self;
}

- (void)SetTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)SetFontSize:(int)size
{
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:size];
}

- (void)SetTitleColor:(CGRect)rgbaColor
{
    titleLabel.textColor = [UIColor colorWithRed:255/rgbaColor.origin.x green:255/rgbaColor.origin.y blue:255/rgbaColor.size.width alpha:255/rgbaColor.size.height];
}

- (void)SetTextAlignment:(NSString *)textAlignment
{
    if ([textAlignment isEqualToString:@"CENTER"])
    {
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if([textAlignment isEqualToString:@"LEFT"])
    {
        titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if([textAlignment isEqualToString:@"RIGHT"])
    {
        titleLabel.textAlignment = NSTextAlignmentRight;
    }
}

- (void)setSeparator:(BOOL)_separator
{
    separator.hidden = _separator;
}

- (void)setSizeSeparator:(int)size
{
    separatorSize = size;
}

- (void)SetSeparatorColor:(UIColor *)color
{
    separator.backgroundColor = color;
}

- (void)SetTextFrame:(CGRect)f
{
    titleLabel.frame = f;
}

- (void)RefreshElement
{
    titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, self.frame.size.width, self.frame.size.height);
    separator.frame = CGRectMake(20, self.frame.size.height-separatorSize, self.frame.size.width-40, separatorSize);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor blueColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self delegate] selectElement:self.tag];
    self.backgroundColor = [UIColor clearColor];
}

@end
