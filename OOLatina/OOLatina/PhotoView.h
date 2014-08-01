//
//  AgendaView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "PhotoCell.h"

@interface PhotoView : UIView <UITextFieldDelegate>
{
    UIImageView *background;
    UITableView *mTableView;
    UIActivityIndicatorView *mLoading;
}

- (void)loadPhoto;

@end
