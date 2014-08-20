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
            [[[[iToast makeText:NSLocalizedString(@"photo_downloaded", @"")] setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
        });
    });
}

- (void)setImageUrl:(NSString *)url
{
    mImageUrl = url;
}

- (IBAction)btnShare_tapped:(id)sender {
    mSocialChooser = [[SocialChooser alloc] initWithNibName:@"SocialChooser" bundle:nil];
    mSocialChooser.view.frame = CGRectMake(20, 150, self.view.frame.size.width - 40, 200);
    mSocialChooser.tbvChooser.frame = mSocialChooser.view.frame;
    [self.view addSubview:mSocialChooser.view];
    [self.view bringSubviewToFront:mSocialChooser.view];
    mSocialChooser.delegate = self;
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(mSocialChooser.view.frame.origin.x+mSocialChooser.view.frame.size.width - 15,130,30,30);
    
    [closeButton setImage:[UIImage imageNamed:@"close_icon.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePopup) forControlEvents:UIControlEventTouchUpInside];
//    closeButton.hidden = YES;
    [self.view addSubview:closeButton];

    
}

//The event handling method
- (void)closePopup {
    if (mSocialChooser != nil) {
        [self removeSocialChooserPopup];
    }
}

- (void)FacebookTapped
{
    mFacebookShare = [[TWBFacebookViewController alloc] init];
    [mFacebookShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mFacebookShare.view];
    [self removeSocialChooserPopup];
    [self.view bringSubviewToFront:_vieActionGroup];
}

- (void)TwitterTapped
{
    mTwitterShare = [[TWBTwitterViewController alloc] init];
    [mTwitterShare postTextAndImageWithSLComposeViewController:_imgPhoto.image];
    [self.view addSubview:mTwitterShare.view];
    [self removeSocialChooserPopup];
    [self.view bringSubviewToFront:_vieActionGroup];
}

- (void)removeSocialChooserPopup
{
    [mSocialChooser.view removeFromSuperview];
    [closeButton removeFromSuperview];
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
