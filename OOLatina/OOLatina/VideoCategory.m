//
//  VideoCategory.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "VideoCategory.h"

@implementation VideoCategory

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setCategoryName:(NSString *)_categoryName
{
    categoryName = _categoryName;
}

- (void)setCategoryId:(NSString *)_categoryId
{
    categoryId = _categoryId;
}

- (NSString *)getCategoryId
{
    return categoryId;
}

- (NSString *)getCategoryName
{
    return categoryName;
}

@end
