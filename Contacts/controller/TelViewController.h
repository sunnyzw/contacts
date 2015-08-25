//
//  ViewController.h
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactCell.h"
#import "ContactsInfo.h"
#import "PersonContentModel.h"
#import "RowHeight.h"

#define IDENTIFIER @"ContactTableViewCell"

@interface TelViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

{
    // 要查找的字符串
    NSString * searchStr;
}

// segmentControl
@property (weak, nonatomic) IBOutlet UISegmentedControl *phoneSegment;
// searchBar
@property (weak, nonatomic) IBOutlet UISearchBar *search;
// tableView
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
//查询结果
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

// 数据源数组
@property (nonatomic,strong) NSMutableArray * dataArray;
// 搜索数组
@property (nonatomic,strong) NSMutableArray * searchArray;

@end

