//
//  AgendaCell.h
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaCell : UITableViewCell
{
    UIView *cornerView;
    UILabel *titleEvent;
    UILabel *titleDay;
    UILabel *titleDayLetter;
    UILabel *labelAdress;
    UIImageView *thumbnail;
}

- (void)setAdresse:(NSString *)address;
- (void)setTitleEvent:(NSString *)title;
- (void)setDayLetter:(NSString *)_day;
- (void)setThumbnail:(NSString *)_thumb;
- (void)setDateToDay:(NSString *)day andMonth:(NSString *)month andYear:(NSString *)year;

@end
