//
//  ArtistTableViewCell.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "ArtistTableViewCell.h"

@implementation ArtistTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{  
    [super setSelected:selected animated:animated];
}

@end
