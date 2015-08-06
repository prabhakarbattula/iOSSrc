//
//  HomeViewController.m
//  busticker
//
//  Created by Mrudul Pendharkar on 04/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import "HomeViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "MyLocnSrvcInterface.h"

@interface HomeViewController ()

@property (strong,nonatomic) MyLocnSrvcInterface* locationMgr;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationMgr = [MyLocnSrvcInterface sharedLocationMgr];
    [self.locationMgr startSignificantChangeUpdates];
    /*
    // Do any additional setup after loading the view.
    NSString* stringURL = @"http://api.publictransport.tampere.fi/prod/?user=mrudulpen&pass=@Metabusticker&request=reverse_geocode&coordinate=3327335,6825367&limit=30&radius=100&result_contains=stop";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary *parameters = @{@"UserId": @"24",@"Name":@"Robin"};
    
    NSLog(@"%@",parameters);
    parameters = nil;
    
    // if you want to sent parameters you can use above code
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:stringURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSLog(@"Count: %lu", (unsigned long)[responseObject count]);
         for (id response in responseObject) {
             NSLog(@"keys:%@",[response allKeys]);
         }
         
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
