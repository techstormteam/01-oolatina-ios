//
//  PhotoCustomCell.h
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionCell.h"
#import "Photo.h"
#import "Utility.h"

@interface PhotoCustomCell : UITableViewCell <UICollectionViewDelegate> {
    NSMutableArray *mPhotos;
}

@property (nonatomic, assign) CGSize photoSize;
@property (nonatomic, assign) NSUInteger photoIndex;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UICollectionView *covAlbum;

- (void)setup;
- (void)passPhotoSize:(CGSize)pSize;
- (void)passData:(NSMutableArray *) photos;

@end
