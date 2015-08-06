//
//  StopDetailsTableViewController.m
//  busticker
//
//  Created by Mrudul P on 02/10/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "StopDetailsTableViewController.h"
#import "BusData.h"
#import "BusTickerNetworking.h"

@interface StopDetailsTableViewController ()

@property (strong,nonatomic) NSString* stpCode;
@property (strong,nonatomic) NSMutableArray* BusTimeList;
@property (strong, atomic) NSNotification* localNotification;

@end

@implementation StopDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.BusTimeList) {
        self.BusTimeList = nil;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


    //Declaring Block
    void (^notificationBlock)(NSNotification* note) = ^(NSNotification* note){
        NSLog(@"StopDetailsDataChanged:: Notificaition received");
        NSDictionary* stopData = [[[BusData sharedBusDataManager]stopQueryResults] objectAtIndex:0];//0 because there will be only one object in array for given stop
        NSArray* departures = [stopData objectForKey:@"departures"];
        int count = [departures count];
        for (int i=0; i < count; i++) {
            NSDictionary* data = [departures objectAtIndex:i];
            NSString* lineName = [data objectForKey:@"name1"];
            if([[BusData sharedBusDataManager] belongsToLine:lineName]){
                NSString* bus = [NSString stringWithFormat:@"%@",[data objectForKey:@"time"]];
                if (!self.BusTimeList) {
                    self.BusTimeList = [[NSMutableArray alloc]init];
                }
                [self.BusTimeList addObject:bus];
            }
        }
        [self.tableView reloadData];
    };
    
    //Making network call
    NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
    NSOperationQueue* mainQ = [NSOperationQueue mainQueue];
    self.localNotification = [nfCenter addObserverForName:@"StopDetailsDataChanged" object:nil queue:mainQ usingBlock:notificationBlock ];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.BusTimeList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell) {
        cell.textLabel.text = [self.BusTimeList objectAtIndex:indexPath.row];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) receiveStopCode:(NSString *)shortStopCode
{
    self.stpCode = shortStopCode;
}

@end
