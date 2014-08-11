//
//  AgendaView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaView.h"
#import "CustomTableViewCell.h"
#import "SCUtils.h"

@implementation AgendaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        if([SCUtils isPhone5])
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        else
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        
        [self addSubview:mAgendaScroll];
    }
    return self;
}

- (void)loadEvent:eventList
{
    if([SCUtils isNetworkAvailable])
    {
        [mAgendaScroll removeAllEvent];

        for (int x=0; x<[eventList count]; x++)
        {
            Event *nEvent = [eventList objectAtIndex:x];
            [mAgendaScroll addEvent:nEvent];
        }
        [mAgendaScroll loadEvent];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [eventArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AgendaCell *cell = (AgendaCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AgendaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int modulo = indexPath.row % 2;
    NSLog(@"modulo : %d",modulo);
    if (modulo == 1)
    {
        cell.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7];
    }
    else
    {
        cell.backgroundColor =  [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7];
    }
    
    Event *mEvent = (Event *)[eventArray objectAtIndex:indexPath.row];
    
    cell.tag = indexPath.row;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [cell setTitleEvent:[mEvent getTitle]];
    [cell setDayLetter:[mEvent getDayLetter]];
    [cell setThumbnail:[mEvent getThumbnailEvent]];
    [cell setDateToDay:[mEvent getDayLetter] andMonth:[mEvent getMonth] andYear:[mEvent getYear]];
    [cell setAdresse:[mEvent getVille]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
