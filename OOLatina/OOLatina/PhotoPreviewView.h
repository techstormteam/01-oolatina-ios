//
//  PhotoPreviewView.h
//  OOLatina
//
//  Created by Macbook air on 8/10/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "PhotoShareConfirm.h"
#import "TWBTwitterViewController.h"
#import "TWBFacebookViewController.h"
#import "SocialChooser.h"
#import "MBProgressHUD.h"
#import "iToast.h"

@interface PhotoPreviewView : UIViewController <SocialChooserDelegate>
{
    PhotoShareConfirm *mPhotoShareConfirm;
    TWBTwitterViewController *mTwitterShare;
    TWBFacebookViewController *mFacebookShare;
    SocialChooser *mSocialChooser;
    NSString *mImageUrl;
    UIButton *closeButton;
}

@property (nonatomic, strong) MBProgressHUD   * theHud;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *btnDownload;
@property (strong, nonatomic) IBOutlet UIView *vieActionGroup;


- (void)setImageUrl:(NSString *)url;
- (IBAction)btnDownload_tapped:(id)sender;
- (IBAction)btnShare_tapped:(id)sender;
@end
