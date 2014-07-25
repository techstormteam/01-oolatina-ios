//
//  Utils.h
//  //
//  Created by Shua-Creation.com on 10/04/12.
//  Copyright (c) 2012 Shua-Creation.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonDigest.h>

@interface SCUtils : NSObject
{    
}

// File & Path methods
+ (BOOL)isFileExistAtPath:(NSString *) path;
+ (NSString *)getDocumentPath;
+ (NSString *)getCachePath;

+ (NSString *)hashMd5withFile:(NSString*)path;

// Network methods
+ (BOOL)isNetworkAvailable;
+ (NSString *)stringURLEncoding:(NSString *)string;
+ (NSString *)requeteHTTP:(NSString *) url;
+ (NSArray *)downloadPlistURL:(NSString *) url;
+ (NSData *)downloadFileURL:(NSString *) url;
+ (UIImage *)downloadImageURL:(NSString *) url;

// Determine device methods
+ (NSString *)loadXibModel:(NSString *)xibname;
+ (bool)isPhone5;
+ (bool)isPad;

@end
