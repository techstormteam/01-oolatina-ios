//
//  AgendaMapView.h
//  OOLatina
//
//  Created by Macbook air on 8/11/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AgendaMapView : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

- (void) loadEvent:eventArray;

@end
