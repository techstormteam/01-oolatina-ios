//
//  PhotoPreviewView.h
//  OOLatina
//
//  Created by Macbook air on 8/3/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface PhotoPreviewView : UIView {
    NSString *name;
    NSString *description;
    NSString *url;
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutlet UIButton *btnDownload;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *test;
- (IBAction)testTapped:(id)sender;

- (IBAction)btnDownloadTapped:(id)sender;
- (IBAction)btnShareTapped:(id)sender;

- (void) setup;

@end
