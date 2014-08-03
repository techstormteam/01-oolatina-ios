//
//  Photo.m
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setName:(NSString *)_name
{
    if(_name == nil)
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


- (void)setUrl:(NSString *)_url
{
    if(_url == nil)
    {
        url = @"";
    }
    else
    {
        url = _url;
    }
}

- (NSString *)getUrl
{
    return url;
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
