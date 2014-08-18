//
//  MyAnnotation.h
//  OOLatina
//
//  Created by Macbook air on 8/18/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject
@property (strong, nonatomic) NSString *title;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
@end