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
    NSString *eventId;
    NSMutableArray *photo;
}

- (void)setTitle:(NSString *)_title;
- (NSString *)getTitle;
- (void)setId:(NSString *)_id;
- (NSString *)getId;
- (void)setPhoto:(NSMutableArray *)_photo;
- (NSMutableArray *)getPhoto;

@end
