//
//  InfoViewController.m
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "InfoViewController.h"
#import "SSLunarDate.h"
#import "NSDate+FSExtension.h"
#import "SettingTableController.h"

@interface InfoViewController ()

@property (nonatomic,strong) SSLunarDate * lunarDate;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoSegment.selectedSegmentIndex = 1;
    self.infoSegment.layer.cornerRadius = 15;
    self.infoSegment.layer.masksToBounds = YES;
    self.infoSegment.layer.borderWidth = 1;
    self.infoSegment.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _calendar.appearance.headerDateFormat = @"yyyy年 MMMM";
    _flow = _calendar.flow;
}

#pragma mark - FSCalendarDataSource
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    if (!_lunar) {
        return nil;
    }
    _lunarDate = [[SSLunarDate alloc] initWithDate:date calendar:[NSCalendar currentCalendar]];
    return _lunarDate.dayString;
}

#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date {
    BOOL shouldSelect = date.fs_day != 7;
    if (!shouldSelect) {
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"FSCalendar" message:[NSString stringWithFormat:@"FSCalendar delegate forbid %@  to be selected",[date fs_stringWithFormat:@"yyyy/MM/dd"]] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSLog(@"要选中的日期 : %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    }
    return shouldSelect;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    NSLog(@"选中的日期 : %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar {
    NSLog(@"当前年月 : %@",[calendar.currentMonth fs_stringWithFormat:@"yyyy年 MMMM"]);
}

// storyboard跳转传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[SettingTableController class]]) {
        [segue.destinationViewController setValue:self forKey:@"infoVC"];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)setTheme:(NSInteger)theme {
    if (_theme != theme) {
        _theme = theme;
        switch (theme) {
            case 0:
                _calendar.appearance.weekdayTextColor = kBlueText;
                _calendar.appearance.headerTitleColor = kBlueText;
                _calendar.appearance.eventColor = [kBlueText colorWithAlphaComponent:0.75];
                _calendar.appearance.selectionColor = kBlue;
                _calendar.appearance.headerDateFormat = @"yyyy年 MMMM";
                _calendar.appearance.todayColor = kPink;
                _calendar.appearance.cellStyle = FSCalendarCellStyleCircle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.2;
                break;
            
            case 1:
                _calendar.appearance.weekdayTextColor = [UIColor redColor];
                _calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
                _calendar.appearance.eventColor = [UIColor greenColor];
                _calendar.appearance.selectionColor = [UIColor blueColor];
                _calendar.appearance.headerDateFormat = @"yyyy-MM";
                _calendar.appearance.todayColor = [UIColor redColor];
                _calendar.appearance.cellStyle = FSCalendarCellStyleCircle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
                break;
            
            case 2:
                _calendar.appearance.weekdayTextColor = [UIColor redColor];
                _calendar.appearance.headerTitleColor = [UIColor redColor];
                _calendar.appearance.eventColor = [UIColor greenColor];
                _calendar.appearance.selectionColor = [UIColor blueColor];
                _calendar.appearance.headerDateFormat = @"yyyy/MM";
                _calendar.appearance.todayColor = [UIColor orangeColor];
                _calendar.appearance.cellStyle = FSCalendarCellStyleRectangle;
                _calendar.appearance.headerMinimumDissolvedAlpha = 1.0;
                break;
            
            default:
                break;
        }
    }
}

- (void)setLunar:(BOOL)lunar {
    if (_lunar != lunar) {
        _lunar = lunar;
        [_calendar reloadData];
    }
}

- (void)setFlow:(FSCalendarFlow)flow {
    if (_flow != flow) {
        _flow = flow;
        _calendar.flow = flow;
    }
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    _calendar.selectedDate = selectedDate;
}

- (void)setFirstWeekday:(NSUInteger)firstWeekday {
    if (_firstWeekday != firstWeekday) {
        _firstWeekday = firstWeekday;
        _calendar.firstWeekday = firstWeekday+1;
    }
}

- (IBAction)segmentClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
