//
//  NSString+Utilities.h
//  OfficeSystem
//
//  Created by wangjt on 2017/2/3.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)

//当前时间作为随机数
+ (NSString *)getRandomStringWithDate;

//获取当前软件的版本号
+ (NSString *)currentAppVersionNumber;

//获取版本build
+ (NSString *)currentAppBuildNumber;

//根据传入格式，转换成对应格式字符串
+ (NSString *)getDateWithTimeString:(NSString *)dateStr dateFormat:(NSString *)format;

//字符串时间 转换为Date
+ (NSDate *)getDateFromTimeString:(NSString *)dateStr;

//判断所选时间是否处于某个时间段内
+ (BOOL)validateSelectTime:(NSString *)currentTime withStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime;

//计算传入时间之前或之后一定范围的时间（以小时为单位）
+ (NSString *)getAllowDateTime:(NSString *)time allowRange:(NSInteger)range;
//计算传入时间之前或之后一定范围的时间（以分钟为单位）
+ (NSString *)getAllowDateTime:(NSString *)time allowRangeWithMinute:(NSInteger)range;

//时区转换
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

//Date转String
+ (NSString *)getStringFromDate:(NSDate *)aDate;

+ (int)compareDate:(NSString *)firstDate withDate:(NSString *)secondDate;

//生成字母+数字随机数
+ (NSString *)getColorRandomStringWithNum:(NSInteger)num;



//签名MD5加密
+ (NSString *)MD5:(NSString *)sign;

//字典升序排列
+ (NSString *)parameSort:(NSDictionary *)dic;

//字符串网址检测
+ (NSString *)strUTF8Encoding:(NSString *)str;

//是否有效的HTTP
+ (BOOL)isValidHttpURL:(NSString *)httpurl;
- (BOOL)isValidHttpURL;

//是否有效的手机号
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;
- (BOOL)isValidPhoneNumber;

//去掉电话中的特殊字符
- (NSString *)removeSpecialCharactersFromPhone:(NSString *)phone;

+ (NSString *)getDeviceName;

+ (NSString *)getDeviceIPAddresses;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

@end
