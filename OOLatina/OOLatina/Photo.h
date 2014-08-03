//
//  Photo.h
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : NSObject {
    NSString *url;
    NSString *name;
    NSString *description;
}

- (void)setName:(NSString *)_name;
- (NSString *)getName;
- (void)setUrl:(NSString *)_url;
- (NSString *)getUrl;
- (void)setDescription:(NSMutableArray *)_Description;
- (NSString *)getDescription;

@end
