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

@interface PhotoPreviewView : UIViewController
{
    UIView *mbackPopup;
    UIButton *closeButton;
    UIView *popupView;
    UIViewController *mPhotoShareConfirm;
}

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;



- (IBAction)btnDownload_tapped:(id)sender;
- (IBAction)btnShare_tapped:(id)sender;
@end
