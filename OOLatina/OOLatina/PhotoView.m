//
//  AgendaView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoView.h"
#import "CustomTableViewCell.h"
#import "SCUtils.h"

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        [self loadPhoto];
        
        UIColor *pinkColor = [UIColor colorWithRed:226.0/255.0 green:94.0/255.0 blue:117.0/255.0 alpha:1.0];
        
        
        [self loadPhoto];
    }
    return self;
}


- (void)loadPhoto
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    
    PhotoCell *cell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//
//    int modulo = indexPath.row % 2;
//    NSLog(@"modulo : %d",modulo);
//    if (modulo == 1)
//    {
//        cell.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:0.7];
//    }
//    else
//    {
//        cell.backgroundColor =  [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.7];
//    }
//    
//    Event *mEvent = (Event *)[eventArray objectAtIndex:indexPath.row];
//    
    cell.tag = indexPath.row;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [cell setTitleEvent:@"aaa"];
    [cell setDayLetter:@"aaa"];
    [cell setThumbnail:@"aaa"];
    [cell setDateToDay:@"aaa" andMonth:@"aaa" andYear:@"aaa"];
    [cell setAdresse:@"aaa"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
