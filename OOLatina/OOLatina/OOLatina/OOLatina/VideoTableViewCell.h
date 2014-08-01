//
//  VideoTableViewCell.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell
{
    UIImageView *thumbnail;
    UILabel *title;
}

- (void)loadThumbnail:(NSString *)url;
- (void)setVideoTitle:(NSString *)_title;

@end
