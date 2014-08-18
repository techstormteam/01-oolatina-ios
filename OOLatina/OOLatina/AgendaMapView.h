//
//  AgendaMapView.h
//  OOLatina
//
//  Created by Macbook air on 8/11/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "Event.h"
#import "SCUtils.h"


@interface AgendaMapView : UIViewController<MKMapViewDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSMutableArray *eventList;
    NSMutableArray *annotationList;
}

- (void)addAnnotations:(NSMutableArray *)eventArray;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
