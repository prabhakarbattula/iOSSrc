//
//  FirstViewController.m
//  busticker
//
//  Created by Mrudul Pendharkar on 04/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "LineViewController.h"
#import "LineListTableViewController.h"
#import "BusTickerNetworking.h"
#import "BusData.h"

@interface LineViewController ()
@property (weak, nonatomic) IBOutlet UITextField *busLineNo;
@property (weak, nonatomic) NSString* lineNo;
@end

@implementation LineViewController


- (IBAction)busLineEntered:(id)sender {
    NSString* lineNo = _busLineNo.text;
    _lineNo = lineNo;
    NSLog(@"Line No:%@ Entered",_lineNo);

    BusData* busData = [BusData sharedBusDataManager];
    
    NSURLSessionDataTask* task = [[BusTickerNetworking sharedNetworkManager]requestLine:_lineNo completion:^(NSArray* results, NSError* error){
        if (results) {
            busData.lineQueryResults = results;
            NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
            NSNotification* notification = [NSNotification notificationWithName:@"LineDataChanged" object:nil];
            [nfCenter postNotification:notification];
        }
        else{
            NSLog(@"Error::%@",error);
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    _bt.rootURL = @"http://api.publictransport.tampere.fi/prod";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Preparing Line Navigation");
    LineListTableViewController* ld = [segue destinationViewController];
    [ld sendLineNo:_lineNo];
}

@end
