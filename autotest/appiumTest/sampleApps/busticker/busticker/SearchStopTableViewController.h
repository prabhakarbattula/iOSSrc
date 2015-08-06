//
//  SearchStopTableViewController.h
//  busticker
//
//  Created by Mrudul P on 10/10/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SearchStopTableViewController;

@protocol SearchStopResult <NSObject>

- (void) sendStopData:(NSString*)stopName StopCoordinates:(NSString*)stopCoordinates;

@end

@interface SearchStopTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong,nonatomic) id<SearchStopResult> delegate;

@end
