//
//  RadioView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Radio.h"
#import "UIScrollLinear.h"

@interface RadioView : UIView <RadioDelegate, UIScrollLinearDelegate>
{
    UIImageView *background;
    UIImageView *cover;
    UIImageView *backgroundPlay;
    UILabel *artist;
    UILabel *radioName;
    UIView *backgroundPlayer;
    MPMoviePlayerController *player;
    UIButton *buttonPlay;
    BOOL isPlaying;
    NSString *fluxRadio;
    NSString *itunesURL;
    UIButton *itunesLink;
    NSMutableArray *radioArray;
    UIScrollLinear *mScrollLinear;
}

- (void)setFlux:(NSString *)flux;
- (void)loadCover;
- (void)playRadio;

@end
