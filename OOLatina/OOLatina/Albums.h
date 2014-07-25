//
//  Albums.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Albums : NSObject
{
    NSString *albumTitle;
    NSString *albumId;
}

- (void)setAlbumTitle:(NSString *)album;
- (void)setAlbumId:(NSString *)idalbum;
- (NSString *)getAlbumId;
- (NSString *)getAlbumTitle;

@end
