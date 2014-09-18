//
//  PhotoView.h
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCustomCell.h"
#import "SCUtils.h"
#import "PhotoEvent.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"

@interface PhotoView : UIView <GMGridViewDataSource, PhotoCustomCellDelegate> {
    NSMutableArray *photoEvents;
    NSMutableArray *photos;
    NSMutableArray *sectionSizes;
    UIImageView *background;
    UIView *backgroundPlayer;
    PhotoPreviewView *viePhotoPreview;
    
    UIScrollView *scrollView;
    __gm_weak GMGridView *_gmGridView2;
}

- (void)showPhotoList;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) CGFloat numberOfImageInRow;

@end
