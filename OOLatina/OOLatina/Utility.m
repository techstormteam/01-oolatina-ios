//
//  Utility.m
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "Utility.h"


@implementation Utility

static NSMutableDictionary *cachedImages;

+ (void) saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

+ (UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    if (cachedImages == nil)
    {
        cachedImages = [[NSMutableDictionary alloc] init];
    }

    UIImage *image = [cachedImages objectForKey:fileURL];
    if (image == nil)
    {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
        cachedImages[fileURL] = result;
    } else {
        result = image;
    }
    
    return result;
}

+ (void) downloadImage:(NSString *)url
{
    //Get Image From URL
    UIImage * imageFromURL = [Utility getImageFromURL:url];
    
    //Save Image to Directory
    [Utility saveImage:imageFromURL];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self imageWithImage:image scaledToSize:newSize];
}
@end
