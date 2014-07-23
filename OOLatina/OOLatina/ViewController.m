//
//  ViewController.m
//  OOLatina
//
//  Created by Jérôme Laurent on 11/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mInterface = [[Interface alloc] initWithNibName:[SCUtils loadXibModel:@"Interface"] bundle:nil];
    [self.view addSubview:mInterface.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
