//
//  WebView.h
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebView : UIView <UIWebViewDelegate>
{
    UIWebView *mWebView;
}

- (void)loadURL:(NSString *)url;

@end
