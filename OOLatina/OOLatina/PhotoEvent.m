//
//  Photo.m
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoEvent.h"

@implementation PhotoEvent

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setTitle:(NSString *)_title
{
    if(_title == nil)
    {
        titleEvent = @"";
    }
    else
    {
        titleEvent = _title;
    }
}

- (NSString *)getTitle
{
    return titleEvent;
}

- (void)setCity:(NSString *)_city
{
    if(_city == nil)
    {
        cityEvent = @"";
    }
    else
    {
        cityEvent = _city;
    }
}

- (NSString *)getCity
{
    return cityEvent;
}

- (void)setDescription:(NSString *)_description
{
    if(_description == nil)
    {
        description = @"";
    }
    else
    {
        description = _description;
    }
}

- (NSString *)getDescription
{
    return description;
}

- (void)setDate:(NSDate *)_date
{
    if(_date == nil)
    {
        date = nil;
    }
    else
    {
        date = _date;
    }
}

- (NSDate *)getDate
{
    return date;
}

- (void)setId:(NSString *)_id
{
    if(_id == nil)
    {
        eventId = @"";
    }
    else
    {
        eventId = _id;
    }
}

- (NSString *)getId
{
    return eventId;
}

- (void)setPhoto:(NSMutableArray *)_photo
{
    if(_photo == nil)
    {
        photo = [[NSMutableArray alloc] init];
    }
    else
    {
        photo = _photo;
    }
}
- (NSMutableArray *)getPhoto
{
    return photo;
}

@end
