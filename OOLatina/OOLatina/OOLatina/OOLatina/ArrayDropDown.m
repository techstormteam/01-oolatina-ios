//
//  ArrayDropDown.m
//  OOLatina
//
//  Created by Jérôme Laurent on 21/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "ArrayDropDown.h"

@implementation ArrayDropDown

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)setName:(NSString *)_name
{
    name = _name;
}

- (void)setIdArray:(NSString *)_idarray
{
    idArray = _idarray;
}

- (NSString *)getName
{
    return name;
}

- (NSString *)getIdArray
{
    return idArray;
}

@end
