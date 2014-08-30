//
//  News.h
//  OOLatina
//
//  Created by Macbook air on 8/29/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject {
    NSString *image;
    NSString *title;
    NSString *description;
}

- (void)setTitle:(NSString *)_name;
- (NSString *)getTitle;
- (void)setImage:(NSString *)_url;
- (NSString *)getImage;
- (void)setDescription:(NSMutableArray *)_Description;
- (NSString *)getDescription;


@end
