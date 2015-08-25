//
//  RowHeight.m
//  Contacts_Demo
//
//  Created by SmartDoc on 15/8/13.
//  Copyright (c) 2015年 SmartDoc. All rights reserved.
//

#import "RowHeight.h"

@implementation RowHeight

+ (CGFloat)rowHeight:(NSArray *)array sizeWidth:(CGFloat)aWidth {
    
    CGFloat height;
    for (int i = 0; i < array.count; i++) {
            NSString * string = array[i];
            CGRect rect = [string boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
            height += rect.size.height;
    }
    return height + array.count*10;
}

@end
