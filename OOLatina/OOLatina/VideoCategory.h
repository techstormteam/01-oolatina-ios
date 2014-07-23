//
//  VideoCategory.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoCategory : NSObject
{
    NSString *categoryName;
    NSString *categoryId;
}

- (void)setCategoryName:(NSString *)_categoryName;
- (void)setCategoryId:(NSString *)_categoryId;
- (NSString *)getCategoryId;
- (NSString *)getCategoryName;

@end
