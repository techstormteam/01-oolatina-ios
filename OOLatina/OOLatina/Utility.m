//
//  Utility.m
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void) saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+ (void) downloadImage:(NSString *)url
{
    //Get Image From URL
    UIImage * imageFromURL = [Utility getImageFromURL:url];
    
    //Save Image to Directory
    [Utility saveImage:imageFromURL];
}

@end
