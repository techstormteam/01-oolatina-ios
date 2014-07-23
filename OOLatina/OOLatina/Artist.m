//
//  Artist.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Artist.h"

@implementation Artist

- (id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (void)setArtistName:(NSString *)artist
{
    artistName = artist;
}

- (void)setArtistId:(NSString *)_idartist
{
    artistId = _idartist;
}

- (NSString *)getArtistId
{
    return artistId;
}

- (NSString *)getArtistName
{
    return artistName;
}

@end
