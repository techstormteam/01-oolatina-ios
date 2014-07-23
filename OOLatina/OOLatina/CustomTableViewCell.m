//
//  CustomTableViewCell.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        playMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        playMusic.frame = CGRectMake(270, 5, 30, 30);
        [playMusic setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
        [playMusic addTarget:self action:@selector(setMusic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:playMusic];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMusic
{
    if(isPlaying)
    {
        isPlaying = NO;
        [playMusic setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
    }
    else
    {
        isPlaying = YES;
        [playMusic setImage:[UIImage imageNamed:@"button_pause.png"] forState:UIControlStateNormal];
    }
    [[self delegate] touchPlaying:self.tag];
}

- (void)setPlay:(BOOL)p
{
    if(p)
    {
        isPlaying = YES;
        [playMusic setImage:[UIImage imageNamed:@"button_pause.png"] forState:UIControlStateNormal];
    }
    else
    {
        isPlaying = NO;
        [playMusic setImage:[UIImage imageNamed:@"button_play.png"] forState:UIControlStateNormal];
    }
}

@end
