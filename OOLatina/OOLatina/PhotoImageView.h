//
//  PhotoImageView.h
//  OOLatina
//
//  Created by Macbook air on 8/16/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoImageView : UIImageView {
    Photo *mPhoto;
}

-(void)setPhotoInfo:(Photo *) photo;
-(Photo *)getPhotoInfo;

@end
