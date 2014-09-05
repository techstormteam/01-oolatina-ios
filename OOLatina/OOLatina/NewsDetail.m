//
//  NewsDetail.m
//  OOLatina
//
//  Created by Macbook air on 9/5/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "NewsDetail.h"

@implementation NewsDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *mySelf = [[[NSBundle mainBundle] loadNibNamed:@"NewsDetail" owner:self options:nil] lastObject];
        [self addSubview:mySelf];
        
        newsCellData = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
        newsCellData.contentView.frame = CGRectMake(0, 0, self.mNewsCell.frame.size.width, self.mNewsCell.frame.size.height);
        [self.mNewsCell addSubview:newsCellData.contentView];
    }
    return self;
}

- (void)setNews:(News*)nNews
{
    mNews = nNews;
    self.mDescriptionLabel.text = [nNews getDescription];
    [newsCellData setNews:nNews imageScaleSize:newsCellData.frame.size];
}

@end
