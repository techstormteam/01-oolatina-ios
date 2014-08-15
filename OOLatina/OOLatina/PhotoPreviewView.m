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
        
        [self showHud:NSLocalizedString(@"", @"") superView:_imgPhoto];
        dispatch_queue_t myQueue = dispatch_queue_create("PhotoDownload",NULL);
        dispatch_async(myQueue, ^{
            // Perform long running process
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [Utility getImageFromURL:mImageUrl];
                _imgPhoto.image = image;
                [self hideHud];
            });
        });
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
    [self showHud:NSLocalizedString(@"downloading", @"") superView:self.view];
    dispatch_queue_t myQueue = dispatch_queue_create("PhotoDownload",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [Utility getImageFromURL:mImageUrl];
            [Utility saveImage:image];
            [self hideHud];
            [[[[iToast makeText:NSLocalizedString(@"Photo Downloaded", @"")] setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
        });
    });
    
}

- (void)setImageUrl:(NSString *)url
{
    mImageUrl = url;
}

- (IBAction)btnShare_tapped:(id)sender {
    mSocialChooser = [[SocialChooser alloc] initWithNibName:@"SocialChooser" bundle:nil];
    mSocialChooser.view.frame = CGRectMake(0, 150, self.view.frame.size.width, 200);
    [self.view addSubview:mSocialChooser.view];
    mSocialChooser.delegate = self;
}

- (void)FacebookTapped
{
    mFacebookShare = [[TWBFacebookViewController alloc] init];
    [mFacebookShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mFacebookShare.view];
    [mSocialChooser.view removeFromSuperview];
}

- (void)TwitterTapped
{
    mTwitterShare = [[TWBTwitterViewController alloc] init];
    [mTwitterShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mTwitterShare.view];
    [mSocialChooser.view removeFromSuperview];
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

#pragma mark - ProgressHud
-(void)showHud:(NSString *)text superView:view
{
    if (_theHud == nil) {
        _theHud = [[MBProgressHUD alloc] init];
    }
    
    _theHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _theHud.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    _theHud.labelText = text;
}

-(void)hideHud
{
    [_theHud hide:YES];
}

@end
