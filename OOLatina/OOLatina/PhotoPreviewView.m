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
    mSocialChooser = [[SocialChooser alloc] initWithNibName:@"SocialChooser" bundle:nil];
    [self.view addSubview:mSocialChooser.view];
    mSocialChooser.delegate = self;
}

- (void)FacebookTapped
{
    mFacebookShare = [[TWBFacebookViewController alloc] init];
    [mFacebookShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mFacebookShare.view];
}

- (void)TwitterTapped
{
    mTwitterShare = [[TWBTwitterViewController alloc] init];
    [mTwitterShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mTwitterShare.view];

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
