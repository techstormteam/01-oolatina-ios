//
//  NewsCell.h
//  OOLatina
//
//  Created by Macbook air on 8/27/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *mTitle;
@property (strong, nonatomic) IBOutlet UILabel *mDescription;
@property (strong, nonatomic) IBOutlet UIImageView *mImage;

@end
