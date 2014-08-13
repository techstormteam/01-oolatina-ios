//
//  PhotoPreviewView.m
//  OOLatina
//
//  Created by Macbook air on 8/10/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoPreviewView.h"

@interface PhotoPreviewView ()

@end

@implementation PhotoPreviewView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                      owner:self options:nil];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDownload_tapped:(id)sender {
    UIImage *image = _imgPhoto.image;
    [Utility saveImage:image];
}

- (IBAction)btnShare_tapped:(id)sender {
//    CGRect bounds = CGRectMake(0, self.lblName.frame.size.height + 30, self.view.frame.size.width, self.view.frame.size.height - self.lblName.frame.size.height - 30 - self.lblDescription.frame.size.height - self.btnShare.frame.size.height);
//    self.imgPhoto.frame = bounds;
//    CGRect s = self.view.frame;
//    CGRect nam = self.lblName.frame;
//    CGRect des = self.lblDescription.frame;
//    CGRect pho = self.imgPhoto.frame;
//    CGRect sha = self.btnShare.frame;
    
    popupView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 40, 320)];
    mPhotoShareConfirm = [[PhotoShareConfirm alloc] initWithNibName:@"PhotoShareConfirm" bundle:nil];
    mPhotoShareConfirm.view.bounds = popupView.bounds;
    CGRect a = popupView.bounds;
    CGSize psize = CGSizeMake(mPhotoShareConfirm.imgPhoto.frame.size.width, mPhotoShareConfirm.imgPhoto.frame.size.height);
    mPhotoShareConfirm.imgPhoto.image = [Utility imageWithImage:self.imgPhoto.image scaledToSize:psize];
    [popupView addSubview:mPhotoShareConfirm.view];
    [self.view addSubview:popupView];
}

- (void)cancelTapped
{
    [popupView removeFromSuperview];
    popupView = nil;
}

- (void)shareTapped
{
    [popupView removeFromSuperview];
    popupView = nil;
}

@end
