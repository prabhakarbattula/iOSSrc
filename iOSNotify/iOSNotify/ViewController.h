//
//  ViewController.h
//  iOSNotify
//
//  Created by Mrudul P on 23/03/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end

