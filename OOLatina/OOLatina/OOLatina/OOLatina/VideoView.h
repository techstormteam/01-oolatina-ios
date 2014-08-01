//
//  VideoView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDoubleScroll.h"

@protocol VideoViewDelegate <NSObject>
- (void)showCategoryVideo:(NSString *)idcategory;
@end

@interface VideoView : UIView <UIDoubleScrollDelegate>
{
    UITableView *mTableView;
    NSMutableArray *arrayVideoCategory;
    UIImageView *background;
    UIDoubleScroll *mDoubleScroll;
}

@property (nonatomic,assign) id<VideoViewDelegate> delegate;

- (void)loadCategory;

@end
