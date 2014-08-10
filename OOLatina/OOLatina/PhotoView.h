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

@interface PhotoView : UIView <GMGridViewDataSource> {
    NSMutableArray *photoEvents;
    NSMutableArray *photos;
    NSMutableArray *sectionSizes;
    
    __gm_weak GMGridView *_gmGridView2;
}

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) CGFloat numberOfImageInRow;

@end
