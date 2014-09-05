//
//  AgendaDayCell.m
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaDayCell.h"
#import "Event.h"
#import "CellAgenda.h"

@implementation AgendaDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 25)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:39.0/255.0 blue:116.0/255.0 alpha:1.0];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
        [self addSubview:titleLabel];
        
        yPos = 25;
    }
    return self;
}

- (void)addMutableEvent:(NSMutableArray *)eventMutable
{
    // On recupere le premier event pour obtenir la date
    Event *mEvent = (Event *)[eventMutable objectAtIndex:0];
    
    NSDate *dateEvent = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    dateEvent = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",[mEvent getYear],[mEvent getMonth],[mEvent getDayLetter]]];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM"];
    NSString *dateEventString = [dateFormat stringFromDate:dateEvent];
    
    titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[mEvent getDayLetter],dateEventString,[mEvent getYear]];
    
    int heightOfEvent = 150;
    
    for (int x=0; x<eventMutable.count; x++)
    {
        Event *uEvent = (Event *)[eventMutable objectAtIndex:x];
        CellAgenda *mAgenda = [[CellAgenda alloc] initWithFrame:CGRectMake(0, yPos, self.frame.size.width, heightOfEvent)];
        [mAgenda addEvent:uEvent];
        [self addSubview:mAgenda];
        mAgenda.delegate = self;
        yPos = yPos + heightOfEvent;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, yPos);
    }
}

- (void)tappedCellAgenda:(Event*) event
{
    [self.delegate tappedCellAgenda:event];
}

@end
