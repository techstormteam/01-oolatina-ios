//
//  AgendaCell.m
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 80)];
        cornerView.layer.cornerRadius = 5;
        [cornerView.layer setMasksToBounds:YES];
        cornerView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.75];
        [self addSubview:cornerView];
        
        titleEvent = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 180, 40)];
        titleEvent.numberOfLines = 3;
        titleEvent.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0];
        titleEvent.textColor = [UIColor whiteColor];
        [cornerView addSubview:titleEvent];
        
        UIView *ViewRed = [[UIView alloc] initWithFrame:CGRectMake(270, 0, 50, 35)];
        ViewRed.backgroundColor = [UIColor redColor];
        [cornerView addSubview:ViewRed];
        
        titleDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleDay.textColor = [UIColor whiteColor];
        titleDay.numberOfLines = 2;
        titleDay.textAlignment = NSTextAlignmentCenter;
        titleDay.text = @"\nMARS";
        titleDay.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0];
        [ViewRed addSubview:titleDay];
        
        UIView *ViewWhite = [[UIView alloc] initWithFrame:CGRectMake(270, 35, 50, 35)];
        ViewWhite.backgroundColor = [UIColor whiteColor];
        [cornerView addSubview:ViewWhite];
        
        titleDayLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        titleDayLetter.textColor = [UIColor grayColor];
        titleDayLetter.numberOfLines = 1;
        titleDayLetter.textAlignment = NSTextAlignmentCenter;
        titleDayLetter.text = @"20";
        titleDayLetter.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
        [ViewWhite addSubview:titleDayLetter];
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [cornerView addSubview:thumbnail];
        
        labelAdress = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 180, 60)];
        labelAdress.textColor = [UIColor whiteColor];
        labelAdress.numberOfLines = 4;
        labelAdress.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [cornerView addSubview:labelAdress];
    }
    return self;
}

- (void)setTitleEvent:(NSString *)title
{
    titleEvent.text = title;
}

- (void)setDayLetter:(NSString *)_day
{
    titleDayLetter.text = _day;
}

- (void)setThumbnail:(NSString *)_thumb
{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_thumb]];
    thumbnail.image = [UIImage imageWithData:data];
}

- (void)setDateToDay:(NSString *)day andMonth:(NSString *)month andYear:(NSString *)year
{
    NSDate *dating = [[NSDate alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    dating = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,month,day]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEEE"];
    
    NSDate *datingMonth = [dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",year,month,day]];
    NSDateFormatter *uf = [[NSDateFormatter alloc] init];
    [uf setDateFormat:@"MMM"];
    
    titleDay.text = [NSString stringWithFormat:@"%@\n%@",[df stringFromDate:dating],[uf stringFromDate:datingMonth]];
}

- (void)setAdresse:(NSString *)address
{
    labelAdress.text = address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
