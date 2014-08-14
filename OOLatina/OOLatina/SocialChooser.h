//
//  SocialChooser.h
//  OOLatina
//
//  Created by Macbook air on 8/14/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialChooser;

@protocol SocialChooserDelegate <NSObject>

- (void)FacebookTapped;
- (void)TwitterTapped;

@end

@interface SocialChooser : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger socialNumber;
@property (nonatomic, weak) id<SocialChooserDelegate> delegate;

@end
