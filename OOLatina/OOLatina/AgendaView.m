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
        
        mNotFound = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mNotFound.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:0.75];
        mNotFound.text = NSLocalizedString(@"event_not_found", @"c");
        mNotFound.textAlignment = UITextAlignmentCenter;
        mNotFound.textColor = [UIColor whiteColor];
        [mNotFound setFont: [UIFont fontWithName:@"Arial" size:24.0f]];
        
        if([SCUtils isPhone5])
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        else
        {
            mAgendaScroll = [[AgendaScroll alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
        }
        mAgendaScroll.delegate = self;
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
        [self hideEventNotFound];
        eventArray = eventList;
        [mAgendaScroll removeAllEvent];
        int count = 0;
        for (int x=0; x<eventArray.count; x++)
        {
            Event *nEvent = [eventArray objectAtIndex:x];
            [mAgendaScroll addEvent:nEvent];
            count++;
        }
        
        
//        Event *nEvent = [[Event alloc] init];
//        [nEvent setTitle:@"dsgkk"];
//        [nEvent setVille:@"dsgkk"];
//        [nEvent setYear:@"dsgkk"];
//        [nEvent setThumbnailEvent:@"http://www.joneshamiltonag.com/jh/wp-content/uploads/2011/10/Poultry-processing-1-500x248.jpg"];
//        [nEvent setPhoneNumber:@"dsgkk"];
//        [nEvent setName:@"dsgkk"];
//        [nEvent setMonth:@"dsgkk"];
//        [nEvent setLongitude:10];
//        [nEvent setLatitude:20];
//        [nEvent setEventDay:@"dskhgvoisdn"];
//        [nEvent setEventDay:@"dsgkk"];
//        [nEvent setCodePostal:@"dsgkk"];
//        [nEvent setAdresse:@"dsgkk"];
//        [mAgendaScroll addEvent:nEvent];
//        
//        nEvent = [[Event alloc] init];
//        [nEvent setTitle:@"dsgkk"];
//        [nEvent setVille:@"dsgkk"];
//        [nEvent setYear:@"dsvdsgkk"];
//        [nEvent setEventDay:@"dskhgvdswoisdn"];
//        [nEvent setThumbnailEvent:@"http://www.joneshamiltonag.com/jh/wp-content/uploads/2011/10/Poultry-processing-1-500x248.jpg"];
//        [nEvent setPhoneNumber:@"dsgkk"];
//        [nEvent setName:@"dsgkk"];
//        [nEvent setMonth:@"dswfqgkk"];
//        [nEvent setLongitude:10];
//        [nEvent setLatitude:20];
//        [nEvent setEventDay:@"dsgkk"];
//        [nEvent setCodePostal:@"dsgkk"];
//        [nEvent setAdresse:@"dsgkk"];
//        [mAgendaScroll addEvent:nEvent];
//        
//        count++;
        
        
        [mAgendaScroll setCurrentEventCount:0];
        [mAgendaScroll loadEventPart:10];
        if (count <= 0) {
            [self showEventNotFound];
        }
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
        [self hideEventNotFound];
//        [self showHud:NSLocalizedString(@"loading", @"") superView:self];
        [[[[iToast makeText:NSLocalizedString(@"Discover events arround 1 KM from here", @"")] setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
        
        CGFloat arroundRadius = 1000;
        [mAgendaScroll removeAllEvent];
        int count = 0;
        for (int x=0; x<[eventList count]; x++)
        {
            Event *nEvent = [eventList objectAtIndex:x];
            if ([self isInside:nEvent radius:arroundRadius]) {
                [mAgendaScroll addEvent:nEvent];
                count++;
            }
        }
        [mAgendaScroll loadEventPart:10];
//        [self hideHud];
        if (count <= 0) {
            [self showEventNotFound];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connexion" message:@"Verifier votre connexion à internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (bool)isInside:(Event *)ev radius:(CGFloat)rad {
    CLLocation *curLocation = currentLocation;
//    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:17 longitude:18];
    CLLocation *agendaLocation = [[CLLocation alloc] initWithLatitude:[ev getLatitude] longitude:[ev getLongitude]];
    CLLocationDistance distance = [curLocation distanceFromLocation:agendaLocation];
    
    if (distance <= rad) {
        return YES;
    }
    return NO;
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
    currentLocation = newLocation;
    
    if (currentLocation != nil) {
//        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}

#pragma mark - NotFound
-(void)showEventNotFound
{
    [self addSubview:mNotFound];
}

-(void)hideEventNotFound
{
    [mNotFound removeFromSuperview];
}

#pragma mark - ProgressHud
-(void)showHud:(NSString *)text superView:view
{
    if (_theHud == nil) {
        _theHud = [[MBProgressHUD alloc] init];
    }
    
    _theHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _theHud.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    _theHud.labelText = text;
}

-(void)hideHud
{
    [_theHud hide:YES];
}

- (void)tappedCellAgenda:(Event*) event
{
    [self.delegate tappedCellAgenda:event];
}

@end
