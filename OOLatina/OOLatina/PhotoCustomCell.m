//
//  PhotoCustomCell.m
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCustomCell.h"

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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSArray* sectionArray = [_data objectAtIndex:section];
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"PhotoCollectionCell";
    
    PhotoCollectionCell* newCell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    if (newCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        newCell = [nib objectAtIndex:0];
    }
    
    // init image
    newCell.imgPhoto.image = [Utility getImageFromURL:@"http://farm4.static.flickr.com/3092/2915896504_a88b69c9de.jpg"];
    //    newCell.imgPhoto = [NSString stringWithFormat:@"Section:%d, Item:%d", indexPath.section, indexPath.item];
    return newCell;
}



@end
