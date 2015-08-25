//
//  InfoViewController.h
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

#define kPink [UIColor colorWithRed:198/255.0 green:51/255.0 blue:42/255.0 alpha:1.0]
#define kBlue [UIColor colorWithRed:31/255.0 green:119/255.0 blue:219/255.0 alpha:1.0]
#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]

@interface InfoViewController : UIViewController <UIScrollViewDelegate, FSCalendarDataSource, FSCalendarDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *infoSegment; //segmentControl

@property (weak, nonatomic) IBOutlet FSCalendar *calendar; //日历控件

@property (assign, nonatomic) NSInteger theme; //主题
@property (assign, nonatomic) FSCalendarFlow flow; //滑动方向
@property (assign, nonatomic) BOOL lunar; //阴历
@property (copy,   nonatomic) NSDate *selectedDate; //选择日期
@property (assign, nonatomic) NSUInteger firstWeekday; //起始日

@end
