//
//  PhotoPreviewView.m
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoPreviewView.h"
#import "FSBasicImage.h"
#import "FSImageView.h"

@implementation PhotoPreviewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)testTapped:(id)sender {
    NSLog(@"fhjdsf");
}

- (IBAction)btnDownloadTapped:(id)sender {
    NSLog(@"fhjdsf");
}

- (IBAction)btnShareTapped:(id)sender {
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

-(void) saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)downloadImage
{
    //Get Image From URL
    UIImage * imageFromURL = [self getImageFromURL:url];
    
    //Save Image to Directory
    [self saveImage:imageFromURL];
}

- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"PhotoPreviewView"
                                  owner:self options:nil];
    url = @"http://www.saudimac.com/ar/wp-content/uploads/2010/10/etkalem-app-icon.jpg";
    name = @"moi";
    description = @"hehe";
    [self downloadImage];
    
    
//    FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/1.jpg"] name:@"Photo 1"];
    FSImageView *imgView = [[FSImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    [imgView setu]
    UIImage *imaage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3092/2915896504_a88b69c9de.jpg"]]];
    
    imgView.imageView.image =  imaage;
    [self addSubview:self.test];
//    self.view.frame = [UIScreen mainScreen].bounds;
//    [self addSubview:self.view];
}


@end
