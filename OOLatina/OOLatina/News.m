//
//  News.m
//  OOLatina
//
//  Created by Macbook air on 8/29/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "News.h"

@implementation News

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setTitle:(NSString *)_name
{
    if(_name == nil)
    {
        title = @"";
    }
    else
    {
        title = _name;
    }
}

- (NSString *)getTitle
{
    return title;
}


- (void)setImage:(NSString *)_url
{
    if(_url == nil)
    {
        image = @"";
    }
    else
    {
        image = _url;
    }
}

- (NSString *)getImage
{
    return image;
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


@end
