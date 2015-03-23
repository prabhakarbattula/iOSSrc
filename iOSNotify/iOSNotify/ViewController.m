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
    if(self.clmanager == nil){
        self.clmanager = [[CLLocationManager alloc]init];
        [self.clmanager requestAlwaysAuthorization];
    }
    self.clmanager.delegate = self;
    [self.clmanager startMonitoringSignificantLocationChanges];
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
        [self.clmanager requestAlwaysAuthorization];
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

@end
