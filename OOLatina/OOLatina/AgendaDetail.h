//
//  AgendaDetail.h
//  OOLatina
//
//  Created by Macbook air on 9/4/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAgenda.h"
#import "AgendaDescription.h"

@interface AgendaDetail : UIView {
    CellAgenda *mCellAgenda;
    AgendaDescription *mAgendaDescription;
    UIImageView *background;
    UIView *backgroundPlayer;
    
    UIButton *descriptionButton;
    UIButton *mapButton;
}

- (void)setEvent:(Event *)uEvent;

@end
