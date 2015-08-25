//
//  ContactsModel.h
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#define NAME @"Name"
#define COMPANY @"Company"
#define TEL @"Tel"
#define EMAIL @"Email"
#define NUMBER @"Number"
#define HEADER_IMAGE @"HeaderImage"

@interface ContactsInfo : NSObject

@property (nonatomic,strong) NSMutableArray * contactArray;

+ (id)shareContact;

@end
