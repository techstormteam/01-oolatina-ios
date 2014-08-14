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

@interface PhotoPreviewView : UIViewController <PhotoShareConfirmDelegate, SocialChooserDelegate>
{
    UIView *mbackPopup;
    UIButton *closeButton;
    UIView *popupView;
    PhotoShareConfirm *mPhotoShareConfirm;
    TWBTwitterViewController *mTwitterShare;
    TWBFacebookViewController *mFacebookShare;
    SocialChooser *mSocialChooser;
}

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;



- (IBAction)btnDownload_tapped:(id)sender;
- (IBAction)btnShare_tapped:(id)sender;
@end
