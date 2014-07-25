//
//  TableViewElement.h
//  Framework iOS - http://studio.shua-creation.com - Copyright 2014
//  ================================================================
//  Framework v0.1

#import <UIKit/UIKit.h>

@protocol TableViewElementDelegate <NSObject>
- (void)selectElement:(int)row;
@end

@interface TableViewElement : UIView
{
    UILabel *titleLabel;
    UIView *separator;
    int separatorSize;
}

@property (nonatomic,assign) id<TableViewElementDelegate> delegate;

- (void)SetTitle:(NSString *)title;
- (void)SetFontSize:(int)size;
- (void)SetTitleColor:(CGRect)rgbaColor;
- (void)SetTextAlignment:(NSString *)textAlignment;
- (void)SetTextFrame:(CGRect)f;

- (void)SetSeparatorColor:(UIColor *)color;

- (void)RefreshElement;

@end
