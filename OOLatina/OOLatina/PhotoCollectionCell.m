//
//  PhotoCollectionCell.m
//  OOLatina
//
//  Created by Macbook air on 8/2/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell

@synthesize imgPhoto = _imgPhoto;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"PhotoCollectionCell"
                                  owner:self options:nil];
    //    [self addSubview:self.view];
}

@end
