//
//  Video.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Video.h"

@implementation Video

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setVideoTitle:(NSString *)title
{
    videoTitle = title;
}

- (void)setVideoId:(NSString *)idv
{
    videoId = idv;
}

- (void)setVideoThumbnail:(NSString *)thumb
{
    videoThumbnail = thumb;
}

- (NSString *)getVideoThumbnail
{
    return videoThumbnail;
}

- (NSString *)getVideoId
{
    return videoId;
}

- (NSString *)getTitle
{
    return videoTitle;
}

@end
