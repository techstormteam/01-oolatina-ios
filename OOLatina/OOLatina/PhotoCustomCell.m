//
//  PhotoCustomCell.m
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCustomCell.h"
#import "UIImage+Resize.h"

@implementation PhotoCustomCell

@synthesize lblTitle = mTitle;
@synthesize covAlbum = mAlbum;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Initialization code
        _photoIndex = 0;
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"PhotoCustomCell"
                                  owner:self options:nil];
//    [self addSubview:self.view];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return ((mPhotos.count - 1) / 3) + 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSArray* sectionArray = [_data objectAtIndex:section];
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"PhotoCollectionCell";
    
    PhotoCollectionCell* newCell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    if (newCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        newCell = [nib objectAtIndex:0];
//        [newCell addTarget:self action:@selector(checkmarkPressed:) forControlEvents:UIControlEventTouchUpInside]
    }
    
    if (_photoIndex < [mPhotos count]) {
        // init image
        Photo *photo = [mPhotos objectAtIndex:_photoIndex];
        NSString *url = [photo getUrl];
        
        UIImage *img = [Utility getImageFromURL:url];
        CGFloat sa = newCell.imgPhoto.frame.origin.x;
        sa = newCell.imgPhoto.frame.origin.y;
        sa = newCell.imgPhoto.frame.size.height;
        sa = newCell.imgPhoto.frame.size.width;
        
        newCell.imgPhoto.frame = CGRectMake(newCell.imgPhoto.frame.origin.x, newCell.imgPhoto.frame.origin.y, _photoSize.height,_photoSize.width);
//        UIImage *scaledImage = [img resizedImageToFitInSize:_photoSize scaleIfSmaller:true];
        UIImage *scaledImage = img;
        newCell.imgPhoto.image = scaledImage;
        sa = newCell.imgPhoto.frame.size.height;
        sa = newCell.imgPhoto.frame.size.width;
        CGFloat h = scaledImage.size.height;
        CGFloat w = scaledImage.size.width;
//        newCell.imgPhoto.center = newCell.imgPhoto.superview.center;
        _photoIndex++;
    }
    return newCell;
}

//didSelect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionCell *cell = (PhotoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *s = @"vdsv";
    NSString *a = s;
}

- (void)passPhotoSize:(CGSize) pSize;
{
    _photoSize = pSize;
}

- (void)passData:(NSMutableArray *) photos
{
    mPhotos = photos;
}

@end
