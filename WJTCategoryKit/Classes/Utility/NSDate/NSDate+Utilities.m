//
//  NSDate+Utilities.m
//  OfficeSystem
//
//  Created by wei on 2017/8/30.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSString *)timeLine:(NSString *)timestamp {

    NSTimeInterval time = [timestamp doubleValue] / 1000;
    NSDate *compareDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    NSInteger temp = 0;
    NSString *result;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval / 60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp / 60) < 24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else /*if((temp = temp/24) < 30)*/{
        temp = temp / 24;
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
//    else if((temp = temp/30) < 12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp / 12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    
    return result;
}

@end
