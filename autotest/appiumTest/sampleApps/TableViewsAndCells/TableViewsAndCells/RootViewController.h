//
//  RootViewController.h
//  TableViewsAndCells
//
//  Created by Cole Joplin on 9/28/12.
//  Copyright (c) 2012 Hughes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *tableData;

@end
