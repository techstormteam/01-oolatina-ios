//
//  Albums.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Albums.h"

@implementation Albums

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setAlbumTitle:(NSString *)album
{
    albumTitle = album;
}

- (void)setAlbumId:(NSString *)idalbum
{
    albumId = idalbum;
}

- (NSString *)getAlbumId
{
    return albumId;
}

- (NSString *)getAlbumTitle
{
    return albumTitle;
}

@end
