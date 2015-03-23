//
//  ViewController.m
//  iOSNotify
//
//  Created by Mrudul P on 23/03/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UITextField *textEntry;
@property (strong, nonatomic) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UITextField *intervalText;
@property (strong) CLLocationManager* clmanager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    self.clmanager = [[CLLocationManager alloc] init];
    self.clmanager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.clmanager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.clmanager requestWhenInUseAuthorization];
    }
    
    [self.clmanager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtnClicked:(id)sender {
    //[self registerForNotification];
   // [self fireNotication];
    self.textEntry.enabled = false;
    self.intervalText.enabled = false;
    if(!self.timer)
        _timer = [NSTimer scheduledTimerWithTimeInterval:[self.intervalText.text integerValue] target:self selector:@selector(fireNotication) userInfo:nil repeats:true];
}
- (IBAction)stopBtnClicked:(id)sender {
  //  [self unregisterNotification];
    [self.timer invalidate];
    self.timer = nil;
    self.textEntry.enabled = true;
    self.intervalText.enabled = true;
}

-(void) fireNotication
{
    NSLog(@"Fire");
    UILocalNotification* localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNotification.alertBody = self.textEntry.text;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Location Access Disabled");
        [self requestAuthorization];
    }
    else {
        NSLog(@"Location Access Enabled");
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Locations Changed %@",locations);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Detect failure ::%@",error);
}
//
//-(void) registerForNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToNotification:) name:@"MyNotif" object:nil];
//    
//}
//-(void) unregisterNotification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//
//-(void) respondToNotification:(NSNotification*) notification{
//    NSLog(@"Notification received");
//}

-(void) requestAuthorization {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.clmanager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

@end
