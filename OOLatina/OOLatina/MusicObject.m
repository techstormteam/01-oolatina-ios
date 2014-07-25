//
//  MusicObject.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "MusicObject.h"

@implementation MusicObject

@synthesize isPlaying;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.isPlaying = NO;
    }
    return self;
}

- (void)setURLMusic:(NSString *)_url
{
    urlMusic = _url;
}

- (NSString *)getURLMusic
{
    return urlMusic;
}

- (void)setTitleMusic:(NSString *)_title
{
    titleMusic = _title;
}

- (NSString *)getTitleMusic
{
    return titleMusic;
}

- (void)setNumberMusic:(NSString *)_number
{
    number = _number;
}

- (NSString *)getNumberMusic
{
    return number;
}

- (BOOL)getisPlaying
{
    return self.isPlaying;
}

- (void)play
{
    if(audioPlayer == nil)
    {
        audioPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:urlMusic]];
    }
    
    if(self.isPlaying)
    {
        self.isPlaying = NO;
        [audioPlayer stop];
    }
    else
    {
        self.isPlaying = YES;
        [audioPlayer play];
    }
}

- (void)stop
{
    isPlaying = NO;
    [audioPlayer stop];
}

@end
