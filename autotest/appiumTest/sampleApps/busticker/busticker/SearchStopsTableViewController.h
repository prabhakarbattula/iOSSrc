//
//  SearchStopsTableViewController.h
//  busticker
//
//  Created by Mrudul P on 22/07/15.
//  Copyright (c) 2015 SimpleSoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchStopTableViewController.h"
//@protocol SearchStopResult <NSObject>
//
//- (void) sendStopData:(NSString*)stopName StopCoordinates:(NSString*)stopCoordinates;
//
//@end

@interface SearchStopsTableViewController : UITableViewController

@property (strong,nonatomic) id<SearchStopResult> delegate;

@end
