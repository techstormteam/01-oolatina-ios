//
//  Photo.h
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoEvent : NSObject {
    NSString *titleEvent;
    NSString *cityEvent;
    NSString *description;
    NSDate *date;
    NSString *eventId;
    NSMutableArray *photo;
}

- (void)setTitle:(NSString *)_title;
- (NSString *)getTitle;
- (void)setCity:(NSString *)_city;
- (NSString *)getCity;
- (void)setDescription:(NSString *)_description;
- (NSString *)getDescription;
- (void)setDate:(NSDate *)_date;
- (NSDate *)getDate;
- (void)setId:(NSString *)_id;
- (NSString *)getId;
- (void)setPhoto:(NSMutableArray *)_photo;
- (NSMutableArray *)getPhoto;

@end
