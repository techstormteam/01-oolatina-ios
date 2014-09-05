//
//  NewsDetail.h
//  OOLatina
//
//  Created by Macbook air on 9/5/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsCell.h"

@interface NewsDetail : UIView {
    News *mNews;
    NewsCell *newsCellData;
}

@property (strong, nonatomic) IBOutlet UIView *mNewsCell;
@property (strong, nonatomic) IBOutlet UILabel *mDescriptionLabel;


- (void)setNews:(News*)nNews;

@end
