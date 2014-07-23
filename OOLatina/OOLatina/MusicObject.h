//
//  MusicObject.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MusicObject : NSObject
{
    NSString *urlMusic;
    NSString *titleMusic;
    NSString *number;
    MPMoviePlayerController *audioPlayer;
}

@property (nonatomic,assign) BOOL isPlaying;

- (void)setURLMusic:(NSString *)_url;
- (void)setTitleMusic:(NSString *)_title;
- (void)setNumberMusic:(NSString *)_number;
- (NSString *)getTitleMusic;
- (NSString *)getNumberMusic;
- (NSString *)getURLMusic;
- (BOOL)getisPlaying;
- (void)play;
- (void)stop;

@end
