//
//  SearchStopsTableViewController.m
//  busticker
//
//  Created by Mrudul P on 22/07/15.
//  Copyright (c) 2015 SimpleSoln. All rights reserved.
//

#import "SearchStopsTableViewController.h"
#import "BusData.h"
#import "BusTickerNetworking.h"

@interface SearchStopsTableViewController () <UISearchDisplayDelegate,UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray* searchFilteredStopList;
@property (strong, nonatomic) NSMutableArray* searchFilteredStopData;
@property (strong, nonatomic) NSMutableArray* historyStopList;
@property (strong, nonatomic) NSMutableArray* historyStopData;
@end

@implementation SearchStopsTableViewController

#pragma mark -- SearchStopTableView Custom Methods
- (void) addStopListByEliminatingDuplicates:(NSArray*)unfilteredList
{
    for (NSDictionary* stop in unfilteredList) {
        NSString* stopName = [stop objectForKey:@"matchedName"];
        if (![self.searchFilteredStopList containsObject:stopName]) {
            [self.searchFilteredStopList addObject:stopName];
            [self.searchFilteredStopData addObject:stop];
        }
    }
}

-(void) initializeArray
{
    self.searchFilteredStopList = nil;
    self.searchFilteredStopData = nil;
    self.searchFilteredStopList = [[NSMutableArray alloc]init];
    self.searchFilteredStopData = [[NSMutableArray alloc]init];
    if(self.historyStopData == nil)
        self.historyStopData = [[NSMutableArray alloc]init];
    if(self.historyStopList == nil)
        self.historyStopList = [[NSMutableArray alloc]initWithObjects:@"his1",@"his2", nil];
}

- (void)startSearch:(NSString *)searchString
{
    BusData* busData = [BusData sharedBusDataManager];
    //Do search here
    BusTickerNetworking* sharedBt = [BusTickerNetworking sharedNetworkManager];
    
    //[sharedBt requestGeoCodeInformation:searchString completion:completionBlock];
    
    [sharedBt requestGeoCodeInformation:searchString completion:^(NSArray* results, NSError* error){
        busData.geoCodeResults = results;
        [self initializeArray];
        //NSArray* result =[busData stopDataFromGeoCodedResult];
        [self addStopListByEliminatingDuplicates:results];
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
    
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self startSearch:searchBar.text];
}

#pragma SearchDisplayDelegate method

//-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self startSearch:searchString];
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeArray];
    
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchBar.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
#warning Potentially incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger rows = 0;
    if (tableView == self.tableView) {
        rows = [self.historyStopList count];
    }
    else if(tableView == self.searchDisplayController.searchResultsTableView){
        rows = [self.searchFilteredStopList count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell_Identifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (tableView == self.tableView) {
        cell.textLabel.text = [self.historyStopList objectAtIndex:indexPath.row];
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [self.searchFilteredStopList objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary* stopData = [self.searchFilteredStopData objectAtIndex:indexPath.row];
    NSString* stopName = [stopData objectForKey:@"matchedName"];
    NSString* stopCoords = [stopData objectForKey:@"coords"];

    [self.historyStopList addObject:stopName];
    [self.historyStopData addObject:stopData];
    
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
