//
//  WebView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 18/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "WebView.h"

@implementation WebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        mWebView.scalesPageToFit = YES;
        mWebView.autoresizesSubviews = YES;
        mWebView.delegate = self;
        [self addSubview:mWebView];
    }
    return self;
}

- (void)loadURL:(NSString *)url
{
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 0.35;"];
    [mWebView stringByEvaluatingJavaScriptFromString:jsCommand];
}

@end
