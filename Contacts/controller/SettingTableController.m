//
//  SettingTableController.m
//  Contacts
//
//  Created by SmartDoc on 15/8/14.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "SettingTableController.h"

@interface SettingTableController ()

@end

@implementation SettingTableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (!indexPath.section) {
        cell.accessoryType = self.infoVC.theme == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 1) {
        cell.accessoryType = self.infoVC.lunar ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 2) {
        cell.accessoryType = indexPath.row == 1 - self.infoVC.flow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.section == 4) {
        cell.accessoryType = indexPath.row == self.infoVC.firstWeekday ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([tableView indexPathForCell:obj].section == indexPath.section) {
            [obj setAccessoryType:UITableViewCellAccessoryNone];
        }
    }];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    if (indexPath.section == 0) {
        if (indexPath.row == self.infoVC.theme) {
            return;
        }
        self.infoVC.theme = indexPath.row;

    } else if (indexPath.section == 1) {
        self.infoVC.lunar = !self.infoVC.lunar;
        
    } else if (indexPath.section == 2) {
        if (self.infoVC.flow == 1 - indexPath.row) {
            return;
        }
        self.infoVC.flow = (FSCalendarFlow)(1 - indexPath.row);
        
    } else if (indexPath.section == 3) {
        self.infoVC.selectedDate = self.datePicker.date;
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        
    } else if (indexPath.section == 4) {
        if (self.infoVC.firstWeekday == indexPath.row) {
            return;
        }
        self.infoVC.firstWeekday = indexPath.row;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
