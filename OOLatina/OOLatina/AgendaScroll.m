//
//  AgendaScroll.m
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaScroll.h"

@implementation AgendaScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mEventArray = [[NSMutableArray alloc] init];
        mEventCell = [[NSMutableArray alloc] init];
        mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:mScrollView];
        
        yPos = 10;
    }
    return self;
}

- (void)removeAllEvent
{
    for (int x=0; x<mEventCell.count; x++)
    {
        AgendaDayCell *mAgendaDayCell = (AgendaDayCell *)[mEventCell objectAtIndex:x];
        [mAgendaDayCell removeFromSuperview];
    }
    
    [mEventCell removeAllObjects];
    [mEventArray removeAllObjects];
    
    yPos = 10;
}

- (void)addEvent:(Event *)_event
{
    // On check si le jour et le mois existe pas déjà
    int result = [self isDayandMonthEventExist:[[_event getDayLetter] intValue] andMonth:[[_event getMonth] intValue]];
    
    // si different de -1 il existe donc on ajoute à sont array
    if(result != -1)
    {
        NSMutableArray *eventArray = (NSMutableArray *)[mEventArray objectAtIndex:result];
        [eventArray addObject:_event];
    }
    else
    {
        // Sa n'existe pas donc on créer une mutable et on l'ajoute à l'array
        NSMutableArray *aEvent = [[NSMutableArray alloc] init];
        [aEvent addObject:_event];
        [mEventArray addObject:aEvent];
    }
}

- (int)isDayandMonthEventExist:(int)day andMonth:(int)month
{
    for (int x=0; x<mEventArray.count; x++)
    {
        NSMutableArray *aEvent = (NSMutableArray *)[mEventArray objectAtIndex:x];
        for (int y=0; y<aEvent.count; y++)
        {
            Event *nEvent = (Event *)[aEvent objectAtIndex:y];
            if([[nEvent getMonth] intValue] == month)
            {
                if([[nEvent getDayLetter] intValue] == day)
                {
                    return x;
                }
            }
        }
    }
    return -1;
}

- (void)loadEvent
{
    for (int x=0; x<mEventArray.count; x++)
    {
        AgendaDayCell *mAgendaDayCell = [[AgendaDayCell alloc] initWithFrame:CGRectMake(5, yPos, mScrollView.frame.size.width-10, 100)];
        mAgendaDayCell.layer.cornerRadius = 5.0;
        [mAgendaDayCell.layer setMasksToBounds:YES];
        [mAgendaDayCell addMutableEvent:[mEventArray objectAtIndex:x]];
        [mEventCell addObject:mAgendaDayCell];
        [mScrollView addSubview:mAgendaDayCell];
        
        yPos = yPos + mAgendaDayCell.frame.size.height + 10;
        mScrollView.contentSize = CGSizeMake(mScrollView.frame.size.width,yPos);
    }
}

@end
