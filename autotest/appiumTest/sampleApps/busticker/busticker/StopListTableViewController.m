//
//  StopListTableViewController.m
//  busticker
//
//  Created by Mrudul Pendharkar on 17/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "StopListTableViewController.h"
#import "StopDetailsTableViewController.h"
#import "BusData.h"
#import "BusTickerNetworking.h"

@interface StopListTableViewController ()

@property (weak, nonatomic) BusData* busData;
@property (strong, nonatomic) NSArray* lineData;
@property (nonatomic) NSUInteger rowNumber;

@end

@implementation StopListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.busData = [BusData sharedBusDataManager];
    NSDictionary* lineStopsData = [self.busData lineDataFromLineQueryResults:_rowNumber]; //Reusing previously fetched data
    self.lineData  = [lineStopsData objectForKey:@"line_stops"];
    
    NSLog(@"%@",self.lineData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.lineData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell) {
        NSDictionary* dict = [self.lineData objectAtIndex:indexPath.row];
        cell.textLabel.text = [dict objectForKey:@"name"];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)receiveLineName:(NSUInteger)rowNumber
{
    _rowNumber = rowNumber;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Stop Details Preparing");
    
    if ([segue.identifier isEqualToString:@"StopDetailsSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary* dict = [self.lineData objectAtIndex:indexPath.row];
        //We should use Code and not ShortCode
        NSString* stopCode = [dict objectForKey:@"code"];
        
        StopDetailsTableViewController* sDLTV = [segue destinationViewController];
        [sDLTV receiveStopCode:stopCode]; // Store this for later retrival
        //Do network query now
        BusData* busData = [BusData sharedBusDataManager];
        [[BusTickerNetworking sharedNetworkManager] requestStopInformation:stopCode completion:^(NSArray *results, NSError *error) {
            busData.stopQueryResults = results;
            NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
//            NSOperationQueue* nsOperationQ = [NSOperationQueue mainQueue];
            NSNotification* notification = [NSNotification notificationWithName:@"StopDetailsDataChanged" object:nil];
            [nfCenter postNotification:notification];
        }];
    }
}

@end
