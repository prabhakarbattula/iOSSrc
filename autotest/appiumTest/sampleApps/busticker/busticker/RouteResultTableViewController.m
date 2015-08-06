//
//  RouteResultTableViewController.m
//  busticker
//
//  Created by Mrudul P on 24/10/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "RouteResultTableViewController.h"
#import "CustomTableViewCell.h"
#import "BusData.h"

@interface RouteResultTableViewController ()

@property NSUInteger routes;
@property (strong, atomic) NSNotification* localNotification;
@property (strong, atomic) BusData* sharedDataMgr;
@end

@implementation RouteResultTableViewController

NSString* nullString = @"<null>";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"myCellIdentifier"];
    
    self.sharedDataMgr = [BusData sharedBusDataManager];
    
    NSNotificationCenter* nfCenter = [NSNotificationCenter defaultCenter];
    NSOperationQueue* mainQ = [NSOperationQueue mainQueue];
    self.localNotification = [nfCenter addObserverForName:@"RoutingDataChanged" object:nil queue:mainQ usingBlock:^(NSNotification* note){
        NSLog(@"RoutingDataChanged::Notificaition received");
        self.routes = [self.sharedDataMgr.routeQueryResults count];
        [self.tableView reloadData];
    }];
    
    
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
    return self.routes;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        /*
        cell.departureText.text = [[self.routeOptions objectAtIndex:indexPath.row] objectForKey:@"departureTime"];
        cell.arrivalText.text = [[self.routeOptions objectAtIndex:indexPath.row] objectForKey:@"arrivalTime"];
        cell.routeText.text = [[self.routeOptions objectAtIndex:indexPath.row] objectForKey:@"routeInfo"];
         */
        }
    else{
        [self processData:cell row:indexPath.row];
        /*
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
         */
    }
    
    return cell;
}

-(NSString*) transportMode :(NSString*)retrivedType
{
    NSString* cycleString = @"cycle";
    NSString* walkString = @"walk";
    NSString* busString = @"1";
    NSString* transportType = @"";
    
    if ([retrivedType isEqualToString:cycleString]) {
        transportType = cycleString;
    } else if([retrivedType isEqualToString:busString]){
        transportType = @"bus";
    } else if ([retrivedType isEqualToString:walkString]) {
        transportType = walkString;
    }
    return transportType;
}

-(NSString*)convertToMins:(NSString*)floatString
{
    NSString* minsString;
    float floatVal = [floatString floatValue];
    float floatMins = floatVal/60;
    minsString = [NSString stringWithFormat:@"%0.2fmins",floatMins];
    return minsString;
}

-(NSString*)extractTime:(NSString*)dateTimeString
{
    NSString* timeString=@"";
   /*
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *usFormatString = [NSDateFormatter dateFormatFromTemplate:@"EyyyyMMdd" options:0 locale:usLocale];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateStyle:NSDateFormatterShortStyle];
    //[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //[dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    //[dateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDate* date = [dateFormatter dateFromString:timeString];
    timeString = [dateFormatter stringFromDate:date];
  */
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[dateTimeString length]];
    for (int i=0; i < [dateTimeString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [dateTimeString characterAtIndex:i]];
        [characters addObject:ichar];
    }
//    int length=0;
    for (int i=8, length = [characters count]; i < length; i++) {
        timeString = [NSString stringWithFormat:@"%@%@",timeString,[characters objectAtIndex:i]];
        if (i == 9) {
            timeString = [NSString stringWithFormat:@"%@:",timeString];
        }
    }
//    timeString = [NSString stringWithFormat:@"%c%c:%c%c",characters];
    return timeString;
}
-(void) processData :(CustomTableViewCell*) cell row:(NSUInteger)index{
    NSArray* legs = [self.sharedDataMgr routeLegsAtIndex:index];
    int legIndex = 0;
    for (NSDictionary* leg in legs) {
        NSArray* locs = [leg objectForKey:@"locs"];
        if (legIndex == 0) {
            cell.lblStartingTimeTxt.text = [self extractTime:[[locs objectAtIndex:0] objectForKey:@"arrTime"]];
            NSString* startingName;
            for (NSDictionary* loc in locs) {
                startingName = [loc objectForKey:@"name"];
                if (![startingName isKindOfClass:[NSNull class]]) {
                    break;
                }
            }
            cell.lblStartingLocationTxt.text = startingName;
        } else {
            NSString* arrivalTime;
            NSString* arrivalName;
            
            for (NSDictionary* loc in locs) {
                NSString* arrName = [loc objectForKey:@"name"];
                arrivalName = [arrName isKindOfClass:[NSNull class]]?arrivalName:arrName;
                arrivalTime = [loc objectForKey:@"depTime"];
            }
            cell.lblArrivalTimeTxt.text = [self extractTime:arrivalTime];
            cell.lblArrivalLocationTxt.text = arrivalName;
        }
        NSString* legsString = cell.lblLegsTxt.text;
        NSString* legsDurationString = cell.lblLegsDuration.text;
        
        if ([legsDurationString isEqualToString:@""]) {
            legsDurationString = [leg objectForKey:@"duration"];
            cell.lblLegsDuration.text = [NSString stringWithFormat:@"%@",[self convertToMins:legsDurationString]];
        } else {
            NSString* currentLegDuration = [leg objectForKey:@"duration"];
            cell.lblLegsDuration.text =[NSString stringWithFormat:@"%@ - %@", legsDurationString, [self convertToMins:currentLegDuration]];
        }
        if ([legsString isEqualToString:@""]) {
            legsString = [self transportMode:[leg objectForKey:@"type"]];
            if ([legsString isEqualToString:@"bus"]) {
                cell.lblNoTxt.text = [leg objectForKey:@"code"];
            }
            cell.lblLegsTxt.text = [NSString stringWithFormat:@"%@",legsString];
        } else {
            NSString* currentLegString = [self transportMode:[leg objectForKey:@"type"]];
            if ([currentLegString isEqualToString:@"bus"]) {
                cell.lblNoTxt.text = [leg objectForKey:@"code"];
            }
            cell.lblLegsTxt.text = [NSString stringWithFormat:@"%@ - %@", legsString, currentLegString];
        }
        legIndex++;
    }
    /*Todo: 1. Starting Time
     Ending Time
     Ending location
     Route walk-bus-walk
     Route Time periods (<walk duration>/<bus duration>/<walk duration>)
    */
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
