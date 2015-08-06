//
//  MyLocnSrvcInterface.m
//  
//
//  Created by Mrudul P on 03/11/14.
//
//

#import "MyLocnSrvcInterface.h"

@interface MyLocnSrvcInterface()

@property (strong,nonatomic) CLLocationManager* clManager;

@end
@implementation MyLocnSrvcInterface

+(instancetype)sharedLocationMgr
{
    static MyLocnSrvcInterface* sharedLocationManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        sharedLocationManager = [[MyLocnSrvcInterface alloc]init];
        if (sharedLocationManager.clManager == nil) {
            sharedLocationManager.clManager = [[CLLocationManager alloc]init];
        }
    });
    return sharedLocationManager;
}
-(void) startVisitChangeUpdates
{
    NSLog(@"Visit Change Updates");
    
    if (self.clManager == nil) {
        NSLog(@"Location Manager cannot be nil");
        return;
//        self.clManager = [[CLLocationManager alloc]init];
    }
    
    [self.clManager startMonitoringVisits];
}
- (void) startSignificantChangeUpdates
{
    NSLog(@"SignificantChangeUpdate");

    if (self.clManager == nil) {
        NSLog(@"Location Manager cannot be nil");
        return;
//        self.clManager = [[CLLocationManager alloc]init];
    }
    self.clManager.delegate = self;
    [self.clManager startMonitoringSignificantLocationChanges];
    [self.clManager requestAlwaysAuthorization];
}
- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"locationManager::Authorisation Change::%d",status);
}
-(void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"locationManage::State Change");
}
-(void) locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    NSLog(@"locationManager::didVisit");
    
}
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locationManager::didUpdateLocations");
    
    // If it's a relatively recent event, turn off updates to save power.
    
    CLLocation* location = [locations lastObject];
    
    NSDate* eventDate = location.timestamp;
    
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    //if (abs(howRecent) < 15.0) {
        
        // If the event is recent, do something with it.
        
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              
              location.coordinate.latitude,
              
              location.coordinate.longitude);
        
    //}
}


@end
