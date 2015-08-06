//
//  LineDetailsTableViewController.m
//  busticker
//
//  Created by Mrudul Pendharkar on 12/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "LineListTableViewController.h"
#import "StopListTableViewController.h"
#import "BusTickerNetworking.h"
#import "BusData.h"

@interface LineListTableViewController ()

@property (weak,nonatomic) NSString* lineNo;
@property (strong, atomic) NSArray* results;
@property (weak, nonatomic) BusData* busData;
@property (strong, atomic) NSNotification* localNotification;

@property (weak, nonatomic) NSString* lineName;
@property (nonatomic) NSUInteger rowNumber;
@end

@implementation LineListTableViewController

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
    
     //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCellIdentifier"];
    _busData = [BusData sharedBusDataManager];
    NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
    NSOperationQueue* mainQ = [NSOperationQueue mainQueue];
    self.localNotification = [nfCenter addObserverForName:@"LineDataChanged" object:nil queue:mainQ usingBlock:^(NSNotification* note){
        NSLog(@"Notificaition received");
        [self.tableView reloadData];
    }];
    
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
    return [[ self.busData lineQueryResults] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   NSString* CellIdentifier = [UITableView re]
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell) {
        cell.textLabel.text = [self.busData lineNameFromLineQueryResults:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.lineName = cell.textLabel.text;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Stop List Preparing");
    
    if ([segue.identifier isEqualToString:@"StopListSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        StopListTableViewController* sLTV = [segue destinationViewController];
        [sLTV receiveLineName:indexPath.row];
    }
}

- (void)sendLineNo:(NSString *)lineNo
{
    _lineNo = lineNo;
}
@end
