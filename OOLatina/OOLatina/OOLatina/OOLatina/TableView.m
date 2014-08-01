//
//  TableView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 12/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "TableView.h"

@implementation TableView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        HeightCells = 30;
        ArrayTable = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)SetHeightCells:(int)size
{
    HeightCells = size;
}

- (void)AddElement:(TableViewElement *)element
{
    CGRect frame = element.frame;
    frame.origin.y = HeightCells * ArrayTable.count;
    frame.size.height = HeightCells;
    frame.size.width = self.frame.size.width;
    element.frame = frame;
    element.delegate = self;
    
    [element RefreshElement];
    
    [self addSubview:element];
    [ArrayTable addObject:element];
}

// Delegate Element Here
- (void)selectElement:(int)row
{
    [[self delegate] selectedRow:row];
}

@end
