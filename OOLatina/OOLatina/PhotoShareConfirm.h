//
//  PhotoShareConfirm.h
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoShareConfirm;

@protocol PhotoShareConfirmDelegate <NSObject>

- (void)cancelTapped;
- (void)shareTapped;

@end

@interface PhotoShareConfirm : UIViewController

@property (nonatomic, weak) id<PhotoShareConfirmDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UITextField *edtText;
- (IBAction)btnShareTapped:(id)sender;
- (IBAction)btnCancelTapped:(id)sender;

@end
