//
//  UIDoubleScroll.h
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageElement.h"

@protocol UIDoubleScrollDelegate <NSObject>
- (void)selectVideoCategory:(NSString *)idElement;
@end

@interface UIDoubleScroll : UIView <ImageElementDelegate>
{
    UIScrollView *mScrollView;
    NSMutableArray *scrollArray;
    int xPos;
    int yPos;
}

@property (nonatomic,assign) id<UIDoubleScrollDelegate> delegate;

- (void)addElement:(NSString *)image andTitle:(NSString *)title andId:(NSString *)_idElement;

@end
