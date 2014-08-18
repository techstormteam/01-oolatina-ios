//
//  MyAnnotation.m
//  OOLatina
//
//  Created by Macbook air on 8/18/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "myAnnotation.h"
#define METERS_PER_MILE 1609.344

@implementation MyAnnotation

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
    if ((self = [super init])) {
        self.coordinate =coordinate;
        self.title = title;
    }
    return self;
}

@end