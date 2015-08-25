//
//  SettingTableController.h
//  Contacts
//
//  Created by SmartDoc on 15/8/14.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@interface SettingTableController : UITableViewController

@property (nonatomic,weak) InfoViewController * infoVC;

// datePicker
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
