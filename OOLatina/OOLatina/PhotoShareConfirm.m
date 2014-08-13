//
//  PhotoShareConfirm.m
//  OOLatina
//
//  Created by Macbook air on 8/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoShareConfirm.h"


@implementation PhotoShareConfirm

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:self options:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShareTapped:(id)sender {
    [self.delegate shareTapped];
}

- (IBAction)btnCancelTapped:(id)sender {
    [self.delegate cancelTapped];
}
@end
