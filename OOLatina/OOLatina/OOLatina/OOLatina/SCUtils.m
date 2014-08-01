//
//  Utils.m
//
//  Created by Shua-Creation.com on 10/04/12.
//  Copyright (c) 2012 Shua-Creation.com All rights reserved.
//

#import "SCUtils.h"

@implementation SCUtils

+(BOOL)isNetworkAvailable 
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

+ (NSString *)stringURLEncoding:(NSString *)string
{
    //return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
    
    return @"";
}

+ (NSString *)requeteHTTP:(NSString *) url
{
	// Requete classique HTTP fonctionne sur des pages Web ecrite en PHP avec réponse.
	// Exemple
	// =======================================================================
	//	downloadManager *DLManager =  [[downloadManager alloc] init];
	//  NSLog(@"%@",[DLManager requeteHTTP:@"http://www.kazbaprod.com/new/ok.php"]);
	
	NSURL *urlRequest = [NSURL URLWithString:url];
	NSError *err = nil;
    
	NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
	
	if(err)
	{
		return nil;
	}
	else
	{
		return html;
	}	
}

+ (UIImage *)downloadImageURL:(NSString *) url
{
	// Requete qui recupere une image en ligne
    // Exemple
	// ========================================================================
	// downloadManager *DLManager =  [[downloadManager alloc] init];
	// UIImage *img = [DLManager downloadImageURL:@"http://www.kazbaprod.com/new/Accueil.png"];
	// UIImageView *t = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
	// t.image = img;
	// [self.view addSubview:t];
	
	NSData * image = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
	return [UIImage imageWithData:image];
}

+ (NSData *)downloadFileURL:(NSString *) url
{
	NSData * file = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];//[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
	return file;
}

+ (NSArray *)downloadPlistURL:(NSString *) url
{
	// Requete pour recupérée un Plist en Live (Renvoie une NSArray *)
	// Exemple
	// =========================================================================
	// downloadManager *DLManager =  [[downloadManager alloc] init];
	// NSDictionary *truc = [DLManager downloadPlistURL:@"http://www.kazbaprod.com/new/ok.php"];
	// NSLog(@"%@",[truc objectForKey:@"truc"]);
	
	NSArray *dict = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:url]];
	return dict;
}

+ (BOOL)isFileExistAtPath:(NSString *) path
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if([filemanager fileExistsAtPath:path])
    {
        return YES;
    }
    return NO;
}

+ (NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

// Pour stocker des documents c'est ici si on ne veut pas être refusé par l'apple store.
+ (NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)hashMd5withString:(NSString*)maChaine
{
	if(maChaine != nil)
	{
		const char *cStr = [maChaine UTF8String];
		unsigned char result[16];
		CC_MD5( cStr, strlen(cStr), result );
		return [[NSString stringWithFormat:
                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3], 
                 result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11],
                 result[12], result[13], result[14], result[15]
                 ] lowercaseString]; 
	}
	
	return nil;
}

// Renvoie le Hash MD5 d'un NSData
+ (NSString *)hashMd5withNSData:(NSData*)mData
{
	NSString *tString = [[NSString alloc] initWithData:mData encoding:NSASCIIStringEncoding];
	const char *cStr = [tString UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [[NSString stringWithFormat:
			 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1], result[2], result[3], 
			 result[4], result[5], result[6], result[7],
			 result[8], result[9], result[10], result[11],
			 result[12], result[13], result[14], result[15]
			 ] lowercaseString]; 
}

// Renvoie le Hash MD5 d'un fichier.
+ (NSString *)hashMd5withFile:(NSString*)path
{
	/*NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
	if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
	
	CC_MD5_CTX md5;
	
	CC_MD5_Init(&md5);
	
	BOOL done = NO;
	while(!done)
	{
		NSAutoreleasePool * pool = [NSAutoreleasePool new];
		NSData* fileData = [handle readDataOfLength:1024];
		CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
		if( [fileData length] == 0 ) done = YES;
		[pool drain];
	}
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final(digest, &md5);
	NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   digest[0], digest[1], 
				   digest[2], digest[3],
				   digest[4], digest[5],
				   digest[6], digest[7],
				   digest[8], digest[9],
				   digest[10], digest[11],
				   digest[12], digest[13],
				   digest[14], digest[15]];*/
	return path;
}

+ (bool)isPhone5
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        NSLog(@"size : %f x %f",[[UIScreen mainScreen] currentMode].size.width,[[UIScreen mainScreen] currentMode].size.height);
        if(CGSizeEqualToSize([[UIScreen mainScreen] currentMode].size, CGSizeMake(640, 1136)))
        {
            return YES;
        }
        
        if([UIScreen mainScreen].scale == 2.f && [[UIScreen mainScreen] bounds].size.height == 568)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (bool)isPad
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
    
    return NO;
}

+ (NSString *)loadXibModel:(NSString *)xibname
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [NSString stringWithFormat:@"%@_iPad",xibname];
    }
    else
    {
        if([self isPhone5])
        {
            return [NSString stringWithFormat:@"%@_iPhone5",xibname];
        }
        else
        {
            return [NSString stringWithFormat:@"%@_iPhone",xibname];
        }
    }
}

+ (NSString *)getDeviceModel
{
    /*struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];*/
    return @"NaN";
}

@end
