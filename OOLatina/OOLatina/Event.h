//
//  Event.h
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSString *titleEvent;
    NSString *thumbnailEvent;
    NSString *day;
    NSString *month;
    NSString *year;
    NSString *phoneNumber;
    NSString *name;
    NSString *ville;
    NSString *adresse;
    NSString *codePostal;
    float longitude;
    float latitude;
}

- (void)setTitle:(NSString *)_title;
- (NSString *)getTitle;
- (void)setEventDay:(NSString *)_day;
- (NSString *)getDayLetter;
- (void)setMonth:(NSString *)_month;
- (void)setYear:(NSString *)_year;
- (void)setPhoneNumber:(NSString *)_phone;
- (void)setAdresse:(NSString *)_address;
- (void)setVille:(NSString *)_ville;
- (void)setCodePostal:(NSString *)_code;
- (void)setLatitude:(CGFloat)_lat;
- (float)getLatitude;
- (void)setLongitude:(CGFloat)_long;
- (float)getLongitude;

- (NSString *)getMonth;
- (NSString *)getYear;
- (NSString *)getAdresse;
- (NSString *)getVille;
- (NSString *)getCodePostal;
- (void)setName:(NSString *)_name;
- (NSString *)getName;

- (void)setThumbnailEvent:(NSString *)_thumbnail;
- (NSString *)getThumbnailEvent;

@end
