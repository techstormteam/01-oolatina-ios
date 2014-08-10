//
//  PhotoPreviewView.h
//  OOLatina
//
//  Created by Macbook air on 8/10/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface PhotoPreviewView : UIViewController {
    NSString *url;
}
@property (strong, nonatomic) IBOutlet UIButton *btnDownload;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

- (void)setUrl:(NSString*)url;
- (IBAction)btnDownload_tapped:(id)sender;
@end
