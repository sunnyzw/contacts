//
//  ContactsModel.m
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "ContactsInfo.h"

static ContactsInfo * contactInfo;

@implementation ContactsInfo

+ (id)shareContact {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contactInfo = [[self alloc] init];
    });
    return contactInfo;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.contactArray = [[NSMutableArray alloc] init];
        
        // 创建通讯录类
        ABAddressBookRef addressBooks = nil;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            addressBooks = ABAddressBookCreateWithOptions(NULL, NULL); //等待同意后向下执行
            dispatch_semaphore_t sema = dispatch_semaphore_create(0); // 发出访问通讯录的请求
            ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
                // 若果用户同意，才会执行block里面的方法
                // 此方法发送一个信号，增加一个资源数
                dispatch_semaphore_signal(sema);
            });
            // 当用户选择同意，block的方法被执行，sema资源数为1
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        // 通讯录信息已获得，开始取出
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBooks);
        // 联系人条目数（使用long而不是用int是为了兼容64位）
        long peopleCount = CFArrayGetCount(results);
        for (int i = 0; i < peopleCount; i++) {
            NSMutableDictionary * contactDict = [[NSMutableDictionary alloc] init];
            
            ABRecordRef record = CFArrayGetValueAtIndex(results, i);
            
            // 完整名字
            NSString * fullName = (__bridge NSString *)ABRecordCopyCompositeName(record);
            // 公司名
            NSString * companyName = (__bridge NSString *)ABRecordCopyValue(record, kABPersonOrganizationProperty);
            // 联系人照片
            NSData * imageData = (__bridge NSData *)ABPersonCopyImageData(record);
            [contactDict setValue:fullName forKey:NAME];
            [contactDict setValue:companyName forKey:COMPANY];
            [contactDict setValue:imageData forKey:HEADER_IMAGE];
            
            // 读取电话（多个）
            ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
            long phoneCount = ABMultiValueGetCount(phones);
            NSMutableArray * numberArray = [[NSMutableArray alloc] init];
            for (int j = 0; j < phoneCount; j++) {
                // label
                CFStringRef label = ABMultiValueCopyLabelAtIndex(phones, j);
                // phone number
                NSString * number = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
                // localize label
                NSString * local = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(label));
                NSDictionary * dict = @{local:number};
                [numberArray addObject:dict];
                [contactDict setValue:numberArray forKey:NUMBER];
            }
            
            // 读取邮箱（多个）
            ABMultiValueRef emails = ABRecordCopyValue(record, kABPersonEmailProperty);
            long emailCount = ABMultiValueGetCount(emails);
            NSMutableArray * emailArray = [[NSMutableArray alloc] init];
            for (int j = 0; j < emailCount; j++) {
                // label
                CFStringRef label = ABMultiValueCopyLabelAtIndex(emails, j);
                // phone number
                NSString * email = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(emails, j));
                // localize label
                NSString * local = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(label));
                NSDictionary * dict = @{local:email};
                [emailArray addObject:dict];
                [contactDict setValue:emailArray forKey:EMAIL];
            }
            [self.contactArray addObject:contactDict];
            
            if (phones && emails) {
                record = NULL;
            }
        }
        
        if (results) {
            results = nil;
        }
        if (addressBooks) {
            addressBooks = NULL;
        }
    }
    return self;
}

@end
