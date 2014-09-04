//
//  AgendaDetail.m
//  OOLatina
//
//  Created by Macbook air on 9/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaDetail.h"

@implementation AgendaDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        backgroundPlayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundPlayer.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        [self addSubview:backgroundPlayer];
        
        int heightOfEvent = 150;
        mCellAgenda = [[CellAgenda alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, heightOfEvent)];
        [self addSubview:mCellAgenda];
        
        mAgendaDescription = [[AgendaDescription alloc] initWithFrame:CGRectMake(0, heightOfEvent, frame.size.width, frame.size.height - heightOfEvent)];
        [self addSubview:mAgendaDescription];
    }
    return self;
}

- (void)setEvent:(Event *)uEvent{
    [mCellAgenda addEvent:uEvent];
    [mAgendaDescription setEvent:uEvent];
}


@end
