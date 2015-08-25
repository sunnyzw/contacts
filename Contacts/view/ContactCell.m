//
//  ContactCell.m
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/13.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    self.headerImage.layer.cornerRadius = 35;
    self.headerImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
