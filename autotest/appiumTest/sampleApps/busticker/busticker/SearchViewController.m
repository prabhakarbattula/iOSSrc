//
//  SecondViewController.m
//  busticker
//
//  Created by Mrudul Pendharkar on 04/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "SearchViewController.h"
#import "BusTickerNetworking.h"
#import "BusData.h"
#import "RouteResultTableViewController.h"
#import "SearchStopsTableViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtHour;
@property (weak, nonatomic) IBOutlet UITextField *txtMins;

@property (weak, nonatomic) IBOutlet UITextField *txtDay;
@property (weak, nonatomic) IBOutlet UITextField *txtMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UITextField *txtStartPlace;
@property (weak, nonatomic) IBOutlet UITextField *txtEndPlace;
@property (strong, nonatomic) NSString* startCoords;
@property (strong, nonatomic) NSString* endCoords;
@property BOOL isStartName;

@end

@implementation SearchViewController

- (IBAction)btnStartPlaceClicked:(id)sender
{
    self.isStartName = true;
}

- (IBAction)btnEndPlaceClicked:(id)sender {
    self.isStartName = false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSMinuteCalendarUnit | NSHourCalendarUnit |  NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit ) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger month = [weekdayComponents month];
    NSInteger year = [weekdayComponents year];
    NSUInteger hour = [weekdayComponents hour];
    NSInteger mins = [weekdayComponents minute];
    
    [self.txtHour setText:[NSString stringWithFormat:@"%lu",(unsigned long)hour ]];
    [self.txtMins setText:[NSString stringWithFormat:@"%lu",(unsigned long)mins ]];
    [self.txtDay setText:[NSString stringWithFormat:@"%lu",(unsigned long)day ]];
    [self.txtMonth setText:[NSString stringWithFormat:@"%lu",(unsigned long)month ]];
    [self.txtYear setText:[NSString stringWithFormat:@"%lu",(unsigned long)year ]];
/*    [self.txtHour setPlaceholder:[NSString stringWithFormat:@"%lu",(unsigned long)hour ]];
    [self.txtHour setPlaceholder:[NSString stringWithFormat:@"%lu",(unsigned long)hour ]];
  */
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendStopData:(NSString *)stopName StopCoordinates:(NSString *)stopCoordinates
{
    //You land here only if intiation was from Start or End Place textbox
    if (self.isStartName) {
        self.txtStartPlace.text = stopName;
        self.startCoords = stopCoordinates;
    }
    else{
        self.txtEndPlace.text = stopName;
        self.endCoords = stopCoordinates;
    }
}

- (IBAction)btnSearchDepartures:(id)sender {
    
    NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
    NSNotification* notification = [NSNotification notificationWithName:@"RoutingDataChanged" object:nil];
    
    //start
    BusTickerNetworking* bt = [BusTickerNetworking sharedNetworkManager];
    NSString* travelDate;
    NSString* travelTime;
    if (0){
        travelDate = [NSString stringWithFormat:@"%@%@%@",self.txtDay.text,self.txtMonth.text,self.txtYear.text ];
        travelTime = [NSString stringWithFormat:@"%@%@",self.txtHour.text,self.txtMins.text];
        
    } else {
        self.startCoords = @"3332126.000000,6819975.000000";
        self.endCoords = @"3328285.000000,6825389.000000";
        travelDate = @"28102014";
        travelTime = @"171";
    }
    [bt requestRoutingInformation:self.startCoords endStopCoordinates:self.endCoords Date:travelDate Time:travelTime completion:^(NSArray *results, NSError *error) {
        if (results) {
            NSLog(@"Results:%@",results);
            BusData* sharedBusData = [BusData sharedBusDataManager];
            [sharedBusData setRouteQueryResults:results];
            [nfCenter postNotification:notification];
        }
    }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[SearchStopTableViewController class]])
    {
        NSLog(@"SearchStopTableViewController preparing Segue");
        SearchStopTableViewController* ssTV = [segue destinationViewController];
        ssTV.delegate = self;
    }
    else if ([[segue destinationViewController] isKindOfClass:[RouteResultTableViewController class]]){
        NSLog(@"RouteResultTableViewController preparing Segue");
    }
    else if([[segue destinationViewController] isKindOfClass:[SearchStopsTableViewController class]]){
        NSLog(@"SearchStopsTableViewController preparing Segue");
        SearchStopsTableViewController* searchStopsTV = [segue destinationViewController];
        searchStopsTV.delegate = self;
    }
}
@end
