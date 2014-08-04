//
//  FirstGuideView.m
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "FirstGuideView.h"

@implementation FirstGuideView


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        NSLog(@"Nib load: %@",nibNameOrNil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setParent:(ViewController*)parentView
{
    self.parent = parentView;
}


- (IBAction)btnNextTapped:(id)sender {
    NSLog(@"Go to main page.");
}
@end
