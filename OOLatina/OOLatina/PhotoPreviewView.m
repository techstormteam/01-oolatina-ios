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
    
    mbackPopup = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 265+20, 400)];
    mbackPopup.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    mbackPopup.hidden = YES;
    [self.view addSubview:mbackPopup];
    
    popupView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 265, 400)];
    popupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    //popupView.hidden = YES;
    [mbackPopup addSubview:popupView];
    
    mPhotoShareConfirm = [[PhotoShareConfirm alloc] initWithNibName:@"PhotoShareConfirm" bundle:nil];
    [popupView addSubview:mPhotoShareConfirm.view];
    
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(popupView.frame.origin.x+popupView.frame.size.width+10,0,30,30);
    [closeButton setImage:[UIImage imageNamed:@"close_icon.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePopup) forControlEvents:UIControlEventTouchUpInside];
    closeButton.hidden = YES;
    [self.view addSubview:closeButton];
}
@end
