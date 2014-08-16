//
//  PhotoImageView.m
//  OOLatina
//
//  Created by Macbook air on 8/16/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoImageView.h"

@implementation PhotoImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setPhotoInfo:(Photo *) photo
{
    mPhoto = photo;
}
-(Photo *)getPhotoInfo
{
    return mPhoto;
}

@end
