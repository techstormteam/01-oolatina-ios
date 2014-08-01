//
//  VideoCategoryView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 14/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCategoryView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *background;
    UIWebView *mWebView;
    UITableView *mTableView;
    NSMutableArray *videoArray;
}

- (void)loadCategory:(NSString *)idcategory;

@end
