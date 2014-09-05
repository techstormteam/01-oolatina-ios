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
    UITapGestureRecognizer *singleFingerTap_Image =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cellNewsTapped:)];
    [self.mImage addGestureRecognizer:singleFingerTap_Image];
    
    UITapGestureRecognizer *singleFingerTap_Title =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cellNewsTapped:)];
    [self.mTitle addGestureRecognizer:singleFingerTap_Title];
}

- (void)cellNewsTapped:(UITapGestureRecognizer *)recognizer {
    [self.delegate tappedNewsCell:mNews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNews:(News*)nNews imageScaleSize:(CGSize)size
{
    mNews = nNews;
    if ([nNews getTitle] == nil) {
        self.mTitle.text = NSLocalizedString(@"no_title", nil);
    } else {
        self.mTitle.text = [nNews getTitle];
    }
    UIImage *image = [Utility getImageFromURL:[nNews getImage]];
    self.mImage.image = [Utility imageWithImage:image scaledToSize:size];
}

@end
