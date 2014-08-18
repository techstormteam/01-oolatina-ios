//
//  Utility.h
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Utility : NSObject

+ (void) saveImage:(UIImage *)image;
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
+ (void) downloadImage:(NSString *)url;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
