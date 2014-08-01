//
//  NavigationBar.h
//  Framework iOS - http://studio.shua-creation.com - Copyright 2014
//  ================================================================
//  Framework v0.1

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView
{
    UIImageView *BackgroundImage;
    UILabel *TitleBar;
    NSString *currentFontName;
}

- (void)SetBackgroundImage:(NSString *)filename;
- (void)SetTitle:(NSString *)title;
- (void)SetTitleColor:(CGRect)rgbaColor;
- (void)SetTitleFontSize:(int)size;

@end
