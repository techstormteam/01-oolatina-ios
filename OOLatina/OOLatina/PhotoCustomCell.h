//
//  PhotoCustomCell.h
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "Utility.h"
#import "GMGridView.h"
#import "PhotoPreviewView.h"
#import "SCUtils.h"
#import "MBProgressHUD.h"
#import "UIImage+Resize.h"
#import "GMGridViewLayoutStrategies.h"
#import "PhotoImageView.h"
#import "AQGridView.h"


@class PhotoCustomCell;

@protocol PhotoCustomCellDelegate <NSObject>

- (void)photoTapped:(UITapGestureRecognizer *)recognizer;

@end

@interface PhotoCustomCell : UIView <AQGridViewDelegate, AQGridViewDataSource> {
    NSMutableArray *mPhotos;
    AQGridView * _gridView;
    __gm_weak GMGridView *_gmGridView;
    UILabel *lblTitle;
    UILabel *lblDate;
    UILabel *lblDayOfWeek;
    UILabel *lblCity;
    UILabel *lblSeeAlbum;
    CAShapeLayer *shapeLayer;
    PhotoPreviewView *viePhotoPreview;
    dispatch_queue_t myQueue;
    UIActivityIndicatorView *mLoading;
}

@property (nonatomic, weak) id<PhotoCustomCellDelegate> delegate;
@property (nonatomic, strong) MBProgressHUD *theHud;
@property (nonatomic, assign) CGSize originalFrameSize;
@property (nonatomic, assign) CGSize photoSize;
@property (nonatomic, assign) NSUInteger photoIndex;

- (void)setup;
- (void)setTitle:(NSString *)title;
- (void)setCity:(NSString *)city;
- (void)setDate:(NSString *)date dayOfWeek:day;
- (void)setSeeAlbum:(NSString *)seeAlbum;
- (void)passPhotoSize:(CGSize)pSize;
- (void)passData:(NSMutableArray *)photos;

@end
