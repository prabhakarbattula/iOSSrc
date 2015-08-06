//
//  SearchStopTableViewController.m
//  busticker
//
//  Created by Mrudul P on 10/10/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "SearchStopTableViewController.h"
#import "BusData.h"
#import "BusTickerNetworking.h"

@interface SearchStopTableViewController ()

@property (strong, nonatomic) NSMutableArray* filteredStopList;
@property (strong, nonatomic) NSMutableArray* filteredStopData;

@end

@implementation SearchStopTableViewController

#pragma mark -- SearchStopTableView Custom Methods
- (void) addStopListByEliminatingDuplicates:(NSArray*)unfilteredList
{
    for (NSDictionary* stop in unfilteredList) {
        NSString* stopName = [stop objectForKey:@"matchedName"];
        if (![self.filteredStopList containsObject:stopName]) {
            [self.filteredStopList addObject:stopName];
            [self.filteredStopData addObject:stop];
        }
    }
}

-(void) initializeArray
{
    self.filteredStopList = nil;
    self.filteredStopData = nil;
    self.filteredStopList = [[NSMutableArray alloc]init];
    self.filteredStopData = [[NSMutableArray alloc]init];
}
#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)startSearch:(NSString *)searchString
{
    BusData* busData = [BusData sharedBusDataManager];
    /*
     void (^completionBlock)(NSArray* results, NSError* error)= ^(NSArray* results, NSError* error){
     busData.geoCodeResults = results;
     self.filteredStopList = [busData stopDataFromGeoCodedResult];
     [self.tableView reloadData];
     };
     */
    //Do search here
    BusTickerNetworking* sharedBt = [BusTickerNetworking sharedNetworkManager];
    
    //[sharedBt requestGeoCodeInformation:searchString completion:completionBlock];
        
    [sharedBt requestGeoCodeInformation:searchString completion:^(NSArray* results, NSError* error){
        busData.geoCodeResults = results;
        [self initializeArray];
        //NSArray* result =[busData stopDataFromGeoCodedResult];
        [self addStopListByEliminatingDuplicates:results];
        [self.tableView reloadData];
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self startSearch:searchBar.text];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeArray];
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
    return [self.filteredStopList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell) {
        cell.textLabel.text = [self.filteredStopList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* stopData = [self.filteredStopData objectAtIndex:indexPath.row];
    NSString* stopName = [stopData objectForKey:@"matchedName"];
    NSString* stopCoords = [stopData objectForKey:@"coords"];
    [self.delegate sendStopData:stopName StopCoordinates:stopCoords];
    [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
