//
//  CustomTableViewCell.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol CustomTableViewCellDelegate <NSObject>
- (void)touchPlaying:(int)number;
@end

@interface CustomTableViewCell : UITableViewCell
{
    UIButton *playMusic;
    NSString *url;
    MPMoviePlayerController *audioPlayer;
    BOOL isPlaying;
}

@property (nonatomic,assign) id<CustomTableViewCellDelegate> delegate;

- (void)setMusic;
- (void)setPlay:(BOOL)p;

@end
