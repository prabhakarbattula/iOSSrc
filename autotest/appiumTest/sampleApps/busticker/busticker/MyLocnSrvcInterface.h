//
//  MyLocnSrvcInterface.h
//  
//
//  Created by Mrudul P on 03/11/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyLocnSrvcInterface : NSObject <CLLocationManagerDelegate>

+(instancetype)sharedLocationMgr;
- (void) startSignificantChangeUpdates;
//- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
//-(void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region;
//-(void) locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit;
//-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end
