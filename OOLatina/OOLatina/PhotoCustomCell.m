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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup
{
    // Initialization code
    _photoIndex = 0;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width, 20)];
    lblTitle.textColor = [UIColor whiteColor];
    [self addSubview:lblTitle];
    
    GMGridView *gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 25, self.frame.size.width, 40)];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    gmGridView.centerGrid = false;
    gmGridView.itemSpacing = 2;
    gmGridView.dataSource = self;
    _gmGridView = gmGridView;
    [self addSubview:_gmGridView];
}

- (void)passPhotoSize:(CGSize) pSize;
{
    _photoSize = pSize;
}

- (void)passData:(NSMutableArray *) photos
{
    mPhotos = photos;
}

- (void)setTitle:(NSString *)title
{
    lblTitle.text = title;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return mPhotos.count;
//    return 10;
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
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tintColor = [UIColor blackColor];
        UIImage *img = [Utility getImageFromURL:url];
        imageView.image = img;
        [cell.contentView addSubview:imageView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        singleTap.numberOfTapsRequired = 1;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:singleTap];

        _photoIndex++;
    }

    return cell;
}

-(void)tapDetected{
    if(viePhotoPreview != nil)
    {
        [self bringSubviewToFront:viePhotoPreview.view];
    }
    else
    {
        viePhotoPreview = [[PhotoPreviewView alloc] initWithNibName:@"PhotoPreviewView" bundle:nil];
        viePhotoPreview.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viePhotoPreview.view];
//        [self bringSubviewToFront:viePhotoPreview];
        
    }
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
