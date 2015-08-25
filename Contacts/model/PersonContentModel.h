//
//  PiecesOfContentModel.h
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/12.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonContentModel : NSObject

@property (nonatomic,assign) NSString * company;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * tel;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSData * imageData;

@end
