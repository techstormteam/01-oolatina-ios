//
//  VideoTableViewCell.m
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 70)];
        [self addSubview:thumbnail];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 30)];
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0];
        title.numberOfLines = 2;
        title.textColor = [UIColor whiteColor];
        [self addSubview:title];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)loadThumbnail:(NSString *)url
{
    // Il faudrait mettre un cache sinon sa serait très long et solicitera le serveur
    // pour rien
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    thumbnail.image = [UIImage imageWithData:data];
}

- (void)setVideoTitle:(NSString *)_title
{
    title.text = _title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
