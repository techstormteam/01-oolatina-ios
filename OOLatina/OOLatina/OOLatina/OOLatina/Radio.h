//
//  Radio.h
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RadioDelegate <NSObject>
- (void)changeRadio:(int)radioSelect;
@end

@interface Radio : UIView
{
    UIImageView *imageRadio;
    UIView *borderSelected;
    BOOL isSelected;
}

@property (nonatomic,assign) id<RadioDelegate> delegate;

- (void)setImage:(NSString *)_image;
- (void)setSelected:(BOOL)_select;

@end
