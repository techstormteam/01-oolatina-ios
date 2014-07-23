//
//  AgendaDayCell.h
//  OOLatina
//
//  Created by Jérôme Laurent on 20/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaDayCell : UIView
{
    UILabel *titleLabel;
    int yPos;
}

- (void)addMutableEvent:(NSMutableArray *)eventMutable;

@end
