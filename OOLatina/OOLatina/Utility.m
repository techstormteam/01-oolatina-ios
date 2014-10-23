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
        if (result != nil)
        {
            cachedImages[fileURL] = result;
        }
    } else {
        result = image;
    }
    
    return result;
}

+ (NSDate *) toNSDate:(NSString *)dateString /// here this is your date with format yyyy-MM-dd HH:mm:ss
{
    NSString *str = dateString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
    return date;
}

+ (NSString *) toDateString:(NSDate *)date // return dd/MM/yyyy
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSLog(@"Converted String : %@",convertedString);
    return convertedString;
}

+ (NSString *) toDayOfWeekString:(NSDate *)date // return dddd
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dddd"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSLog(@"Converted String : %@",convertedString);
    return convertedString;
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
