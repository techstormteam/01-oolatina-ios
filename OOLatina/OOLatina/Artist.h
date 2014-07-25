//
//  Artist.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject
{
    NSString *artistName;
    NSString *artistId;
}

- (void)setArtistName:(NSString *)artist;
- (void)setArtistId:(NSString *)_idartist;
- (NSString *)getArtistId;
- (NSString *)getArtistName;

@end
