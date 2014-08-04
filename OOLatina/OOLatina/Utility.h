//
//  Utility.h
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void) saveImage:(UIImage *)image;
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
+ (void) downloadImage:(NSString *)url;

@end
