//
//  AlbumView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicObject.h"
#import "CustomTableViewCell.h"

@interface AlbumView : UIView <UITableViewDataSource,UITableViewDelegate,CustomTableViewCellDelegate>
{
    UIImageView *jaquette;
    UILabel *titleLabel;
    UILabel *titleAlbum;
    UITableView *mTableViewListMusic;
    NSMutableArray *arrayMusic;
    UIImageView *background;
}

- (void)loadAlbum:(NSString *)idAlbum;
- (void)loadJaquette:(NSString *)url;
- (void)setTitle:(NSString *)title;
- (void)setTitleAlbum:(NSString *)album;
- (void)addMusic:(NSString *)url andTitle:(NSString *)title andNumber:(NSString * )number;

@end
