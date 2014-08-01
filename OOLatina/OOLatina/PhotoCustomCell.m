//
//  PhotoCustomCell.m
//  OOLatina
//
//  Created by Macbook air on 8/1/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCustomCell.h"

@implementation PhotoCustomCell

@synthesize lblTitle = mTitle;
@synthesize cotAlbum = mAlbum;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"PhotoCustomCell"
                                  owner:self options:nil];
//    [self addSubview:self.view];
}

@end
