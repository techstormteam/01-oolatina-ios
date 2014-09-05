//
//  NewsCell.h
//  OOLatina
//
//  Created by Macbook air on 8/27/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Utility.h"

@class NewsCell;

@protocol NewsCellDelegate <NSObject>

- (void)tappedNewsCell:(News*) news;

@end

@interface NewsCell : UITableViewCell {
    News *mNews;
}
@property (nonatomic, weak) id<NewsCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *mTitle;
@property (strong, nonatomic) IBOutlet UIImageView *mImage;

- (void)setNews:(News*)nNews imageScaleSize:(CGSize)size;

@end
