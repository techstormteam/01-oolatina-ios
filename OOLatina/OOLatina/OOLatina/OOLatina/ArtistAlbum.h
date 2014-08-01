//
//  ArtistAlbum.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDoubleScroll.h"

@protocol ArtistAlbumDelegate <NSObject>
- (void)loadAlbum:(NSString *)idAlbum;
@end

@interface ArtistAlbum : UIView <UIDoubleScrollDelegate>
{
    UITableView *mTableView;
    UIDoubleScroll *mDoubleScroll;
    NSMutableArray *arrayAlbum;
    UIImageView *background;
}

@property (nonatomic,assign) id<ArtistAlbumDelegate> delegate;

- (void)getAllAlbum:(NSString *)artist;

@end
