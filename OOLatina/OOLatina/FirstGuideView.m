//
//  FirstGuideView.m
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "FirstGuideView.h"

@implementation FirstGuideView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)btnNextTapped:(id)sender {
}

- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"FirstGuideView"
                                  owner:self options:nil];
    self.view.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.view];
}

@end
