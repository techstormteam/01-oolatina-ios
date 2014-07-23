//
//  ImageElement.h
//  OOLatina
//
//  Created by Jérôme Laurent on 16/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageElementDelegate <NSObject>
- (void)selectImage:(NSString *)idelement;
@end

@interface ImageElement : UIView
{
    UIImageView *imageView;
    UIView *background;
    UIView *bandeau;
    UILabel *labelView;
    NSString *idElement;
}

@property (nonatomic,assign) id<ImageElementDelegate> delegate;

- (void)setImageView:(NSString *)_image;
- (void)setTextView:(NSString *)_text;
- (void)setIdElement:(NSString *)_idElement;

@end
