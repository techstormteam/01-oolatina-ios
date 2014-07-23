//
//  TableView.h
//  Framework iOS - http://studio.shua-creation.com - Copyright 2014
//  ================================================================
//  Framework v0.1

#import <UIKit/UIKit.h>
#import "TableViewElement.h"

@protocol TableViewSCDelegate <NSObject>
- (void)selectedRow:(int)rownumber;
@end

@interface TableView : UIScrollView <TableViewElementDelegate>
{
    NSMutableArray *ArrayTable;
    int HeightCells;
}

@property (nonatomic,assign) id<TableViewSCDelegate> delegate;

- (void)SetHeightCells:(int)size;
- (void)AddElement:(TableViewElement*)element;

@end
