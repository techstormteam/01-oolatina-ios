//
//  ViewController.h
//  OOLatina
//
//  Created by Jérôme Laurent on 11/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "SCUtils.h"
#import "FirstGuideView.h"

//@protocol ViewController <NSObject>
//
//- (void);
//
//@end

@interface ViewController : UIViewController<FirstGuideViewDelegate>
{
    FirstGuideView *mFirstGuideView;
    Interface *mInterface;
    
}

//@property (nonatomic, weak) id<FirstGuideViewDelegate> delegate;
- (void)gotoMainView;

@end
