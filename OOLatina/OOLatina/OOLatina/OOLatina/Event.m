//
//  Event.m
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Event.h"

@implementation Event

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

- (void)setThumbnailEvent:(NSString *)_thumbnail
{
    if(_thumbnail == nil)
    {
        thumbnailEvent = @"";
    }
    else
    {
        thumbnailEvent = _thumbnail;
    }
}

- (NSString *)getThumbnailEvent
{
    return thumbnailEvent;
}

- (NSString *)getTitle
{
    return titleEvent;
}

- (void)setEventDay:(NSString *)_day
{
    day = _day;
}

- (NSString *)getDayLetter
{
    return day;
}

- (void)setMonth:(NSString *)_month
{
    month = _month;
}

- (NSString *)getMonth
{
    return month;
}

- (void)setYear:(NSString *)_year
{
    year = _year;
}

- (NSString *)getYear
{
    return year;
}

- (void)setPhoneNumber:(NSString *)_phone
{
    phoneNumber = _phone;
}

- (void)setAdresse:(NSString *)_address
{
    if([_address isKindOfClass:[NSNull class]])
    {
        adresse = @"";
    }
    else
    {
        adresse = _address;
    }
}

- (NSString *)getAdresse
{
    return adresse;
}

- (void)setVille:(NSString *)_ville
{
    if([_ville isKindOfClass:[NSNull class]])
    {
        ville = @"";
    }
    else
    {
        ville = _ville;
    }
}

- (NSString *)getVille
{
    return ville;
}

- (void)setCodePostal:(NSString *)_code
{
    if([_code isKindOfClass:[NSNull class]])
    {
        codePostal = @"";
    }
    else
    {
        codePostal = _code;
    }
}

- (NSString *)getCodePostal
{
    return codePostal;
}

- (void)setLatitude:(CGFloat)_lat
{
    latitude = _lat;
}

- (void)setLongitude:(CGFloat)_long
{
    longitude = _long;
}

- (void)setName:(NSString *)_name
{
    if([_name isKindOfClass:[NSNull class]])
    {
        name = @"";
    }
    else
    {
        name = _name;
    }
}

- (NSString *)getName
{
    return name;
}

@end
