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

@interface PhotoView : UIView  {
    NSMutableArray *photoEvents;
    NSMutableArray *photos;
    NSMutableArray *sectionSizes;
}

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) NSNumber *numberOfImageInRow;
@property (nonatomic, strong) IBOutlet UITableView *view;

- (void)setup;

@end
