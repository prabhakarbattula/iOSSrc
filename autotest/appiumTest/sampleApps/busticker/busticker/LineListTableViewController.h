//
//  LineDetailsTableViewController.h
//  busticker
//
//  Created by Mrudul Pendharkar on 12/09/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusData.h"

@interface LineListTableViewController : UITableViewController

@property NSUInteger* pageIndex;
-(void) sendLineNo :(NSString*)lineNo;

@end
