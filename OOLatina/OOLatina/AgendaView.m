//
//  AgendaView.m
//  OOLatina
//
//  Created by Jérôme Laurent on 13/03/2014.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaView.h"
#import "CustomTableViewCell.h"
#import "SCUtils.h"

@implementation AgendaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        background.image = [UIImage imageNamed:@"background.png"];
        [self addSubview:background];
        
        if([SCUtils isPhone5])
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        else
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        
        [self addSubview:mAgendaScroll];
    }
    return self;
}

- (void)gettingLocation
{
    locationManager.delegate = self;
}

- (void)loadEvent:eventList
{
    if([SCUtils isNetworkAvailable])
    {
        [mAgendaScroll removeAllEvent];

        for (int x=0; x<[eventList count]; x++)
        {
            Event *nEvent = [eventList objectAtIndex:x];
            [mAgendaScroll addEvent:nEvent];
        }
        [mAgendaScroll loadEvent];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)loadEventArroundMe:eventList
{
    if([SCUtils isNetworkAvailable])
    {
        CGFloat arroundRadius = 1000;
        [mAgendaScroll removeAllEvent];
        
        for (int x=0; x<[eventList count]; x++)
        {
            Event *nEvent = [eventList objectAtIndex:x];
            if ([self isInside:nEvent: arroundRadius]) {
                [mAgendaScroll addEvent:nEvent];
            }
        }
        [mAgendaScroll loadEvent];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (bool)isInside:(Event *)event: (CGFloat)radius {
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[event getLatitude] longitude:[event getLongitude]];;
    CLLocation *agendaLocation = [[CLLocation alloc] initWithLatitude:[event getLatitude] longitude:[event getLongitude]];
    CGFloat dis = [self distance:currentLocation: agendaLocation];
    if (dis < radius) {
        
    }
    return YES;
}

- (CGFloat) distance:(CLLocation *) from: (CLLocation *) to {
    CLLocationDegrees a = abs(from.coordinate.longitude - to.coordinate.longitude);
    CLLocationDegrees b = abs(from.coordinate.latitude - to.coordinate.latitude);
    return sqrt((a * a) + (b * b));
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
//        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}

@end
