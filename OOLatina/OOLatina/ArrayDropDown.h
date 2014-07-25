//
//  ArrayDropDown.h
//  OOLatina
//
//  Created by Jérôme Laurent on 21/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayDropDown : NSObject
{
    NSString *name;
    NSString *idArray;
}

- (void)setName:(NSString *)_name;
- (void)setIdArray:(NSString *)_idarray;
- (NSString *)getName;
- (NSString *)getIdArray;

@end
