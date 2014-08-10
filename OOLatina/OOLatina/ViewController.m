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

    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults]
                               objectForKey:@"aValue"]]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"aValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        mFirstGuideView = [[FirstGuideView alloc] initWithNibName:@"FirstGuideView" bundle:nil];
        mFirstGuideView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        mFirstGuideView.delegate = self;
        [self.view addSubview:mFirstGuideView.view];
    } else {
        [self gotoMainView];
    }
    
    
}

- (void)tappedNext
{
    [self gotoMainView];
}

- (void)gotoMainView
{
    if(mInterface != nil)
    {
        [self.view bringSubviewToFront:mInterface.view];
    }
    else
    {
        mInterface = [[Interface alloc] initWithNibName:[SCUtils loadXibModel:@"Interface"] bundle:nil];
        
        [self.view addSubview:mInterface.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
