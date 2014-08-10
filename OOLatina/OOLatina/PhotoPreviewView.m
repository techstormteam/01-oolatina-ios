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
    
//    UIImage *image = [Utility downloadImage:url];
//    [Utility saveImage:image];
}
@end
