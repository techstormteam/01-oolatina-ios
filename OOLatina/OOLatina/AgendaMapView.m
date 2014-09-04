//
//  AgendaMapView.m
//  OOLatina
//
//  Created by Macbook air on 8/11/14.
//  Copyright (c) 2014 Jérôme Laurent. All rights reserved.
//

#import "AgendaMapView.h"

@interface AgendaMapView ()

@end

@implementation AgendaMapView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mNotFound = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        mNotFound.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        mNotFound.text = NSLocalizedString(@"event_not_found", @"c");
        mNotFound.textAlignment = UITextAlignmentCenter;
        mNotFound.textColor = [UIColor whiteColor];
        [mNotFound setFont: [UIFont fontWithName:@"Arial" size:24.0f]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    
    
//    locationManager.delegate = self;
}

- (void)addAnnotations:(NSMutableArray*)eventArray{
    if([SCUtils isNetworkAvailable])
    {
        [self hideEventNotFound];
        eventList = eventArray;
        [self.mapView removeAnnotations:annotationList];
        for (int x=0; x<[eventArray count]; x++)
        {
            Event *nEvent = [eventArray objectAtIndex:x];
            CLLocationCoordinate2D coordinate1;
            coordinate1.latitude = [nEvent getLatitude];
            coordinate1.longitude = [nEvent getLongitude];
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinate1;
            point.title = [nEvent getTitle];
            point.subtitle = [nEvent getAdresse];
            [annotationList addObject:point];
            [self.mapView addAnnotation:point];
        }
        
        [self initZoomView];
        if ([eventArray count] <= 0) {
            [self showEventNotFound];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadEvent:eventArray
{
    
}

#pragma mark - NotFound
-(void)showEventNotFound
{
    [self.view addSubview:mNotFound];
}

-(void)hideEventNotFound
{
    [mNotFound removeFromSuperview];
}

- (void) initZoomView
{
    if (eventList != nil && eventList.count > 0) {
        Event *nEvent = [eventList objectAtIndex:0];
        CLLocationCoordinate2D firstAgendaLocation;
        firstAgendaLocation.latitude = [nEvent getLatitude];
        firstAgendaLocation.longitude = [nEvent getLongitude];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(firstAgendaLocation, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
//        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
//    }
//}
//
//- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
//    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
//        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
//    }
//}
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
//        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
//    }
//    return nil;
//}

#pragma mark - CLLocationManagerDelegate

//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
//        //        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        //        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
//}

@end
