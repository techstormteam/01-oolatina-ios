//
//  NewsCell.m
//  OOLatina
//
//  Created by Macbook air on 8/27/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
