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


@interface PhotoCustomCell : UIView <GMGridViewDataSource, GMGridViewActionDelegate> {
    NSMutableArray *mPhotos;
    __gm_weak GMGridView *_gmGridView;
    UILabel *lblTitle;
    PhotoPreviewView *viePhotoPreview;
    dispatch_queue_t myQueue;
}

@property (nonatomic, strong) MBProgressHUD *theHud;
@property (nonatomic, assign) CGSize originalFrameSize;
@property (nonatomic, assign) CGSize photoSize;
@property (nonatomic, assign) NSUInteger photoIndex;

- (void)setup;
- (void)setTitle:(NSString *)title;
- (void)passPhotoSize:(CGSize)pSize;
- (void)passData:(NSMutableArray *)photos;

@end
