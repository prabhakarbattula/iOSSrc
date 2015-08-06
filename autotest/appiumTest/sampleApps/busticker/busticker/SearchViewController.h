//
//  SecondViewController.h
//  busticker
//
//  Created by Mrudul Pendharkar on 04/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchStopTableViewController.h"

@interface SearchViewController : UIViewController<SearchStopResult>

-(void)sendStopData:(NSString *)stopName StopCoordinates:(NSString *)stopCoordinates;

@end
