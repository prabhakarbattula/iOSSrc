//
//  CustomTableViewCell.h
//  busticker
//
//  Created by Mrudul P on 24/10/14.
//  Copyright (c) 2014 SimpleSoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblRouteTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblBusNoTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblNoTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblArrivalTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblStartingTimeTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblStartingLocationTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblArrivalLocationTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblArrivalTimeTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblLegsTxt;
@property (weak, nonatomic) IBOutlet UILabel *lblLegsDuration;

@end
