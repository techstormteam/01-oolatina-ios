//
//  Video.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
{
    NSString *videoTitle;
    NSString *videoId;
    NSString *videoThumbnail;
}

- (void)setVideoTitle:(NSString *)title;
- (void)setVideoId:(NSString *)idv;
- (void)setVideoThumbnail:(NSString *)thumb;
- (NSString *)getVideoThumbnail;
- (NSString *)getVideoId;
- (NSString *)getTitle;

@end
