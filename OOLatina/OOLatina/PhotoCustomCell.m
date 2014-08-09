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
@synthesize vieAlbum = mAlbum;


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Initialization code
        _photoIndex = 0;
        
        
    }
    return self;
}

-(void)setup
{
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:mAlbum.bounds];
//    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    _gmGridView = gmGridView;
    _gmGridView.dataSource = self;

    [mAlbum addSubview:_gmGridView];
}

- (void)passPhotoSize:(CGSize) pSize;
{
    _photoSize = pSize;
}

- (void)passData:(NSMutableArray *) photos
{
    mPhotos = photos;
}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return mPhotos.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return _photoSize;
    }
    else
    {
        return _photoSize;
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    CGSize size = CGSizeMake(_photoSize.width, _photoSize.height);
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor redColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_photoIndex < [mPhotos count]) {
        // init image
        Photo *photo = [mPhotos objectAtIndex:_photoIndex];
        NSString *url = [photo getUrl];
        
//        UIImage *img = [Utility getImageFromURL:url];
        
//        newCell.imgPhoto.frame = CGRectMake(newCell.imgPhoto.frame.origin.x, newCell.imgPhoto.frame.origin.y, _photoSize.height,_photoSize.width);
        //        UIImage *scaledImage = [img resizedImageToFitInSize:_photoSize scaleIfSmaller:true];
//        UIImage *scaledImage = img;
//        newCell.imgPhoto.image = scaledImage;
//        newCell.imgPhoto.center = newCell.imgPhoto.superview.center;
        
//        UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        label.text = @"aaa";
//        label.textAlignment = UITextAlignmentCenter;
//        label.backgroundColor = [UIColor clearColor];
//        label.textColor = [UIColor blackColor];
//        label.highlightedTextColor = [UIColor whiteColor];
//        label.font = [UIFont boldSystemFontOfSize:20];
//        [cell.contentView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tintColor = [UIColor blackColor];
        UIImage *img = [Utility getImageFromURL:url];
        imageView.image = img;
        [cell.contentView addSubview:imageView];
        
        _photoIndex++;
    }

    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
//    NSLog(@"Did tap at index %d", position);
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    //empty
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 1)
//    {
//        [_currentData removeObjectAtIndex:_lastDeleteItemIndexAsked];
//        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
//    }
}


@end
