//
//  AudioView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDoubleScroll.h"

@protocol AudioViewDelegate <NSObject>
- (void)loadAllAlbum:(NSString *)artistid;
@end

@interface AudioView : UIView <UIDoubleScrollDelegate>
{
    UIDoubleScroll *mDoubleScroll;
    NSMutableArray *arrayArtist;
    UIImageView *background;
}

@property (nonatomic,assign) id<AudioViewDelegate> delegate;

@end
