//
//  NSString+Utilities.m
//  OfficeSystem
//
//  Created by wangjt on 2017/2/3.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "NSString+Utilities.h"
//加密用到的头文件
#import "CommonCrypto/CommonDigest.h"

#import <AdSupport/AdSupport.h>
#import "sys/utsname.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>


@implementation NSString (Utilities)

//当前时间作为随机数
+ (NSString *)getRandomStringWithDate {
    NSDate *today = [NSDate date];
    NSString *randomCode = [NSString stringWithFormat:@"%llu",(UInt64)([today timeIntervalSince1970]*1000*1000)];
    return randomCode;
}

//获取当前软件的版本号
+ (NSString *)currentAppVersionNumber
{
    NSString *current = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return current;
}

//获取版本build
+ (NSString *)currentAppBuildNumber
{
    NSString *currentBuild = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];;
    return currentBuild;
}

//根据传入格式，转换成对应格式字符串
+ (NSString *)getDateWithTimeString:(NSString *)dateStr dateFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//yyyy年MM月dd日

    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:format];
    
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//字符串时间 转换为Date
+ (NSDate *)getDateFromTimeString:(NSString *)dateStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//yyyy年MM月dd日
    
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

//判断所选时间是否处于某个时间段内
+ (BOOL)validateSelectTime:(NSString *)currentTime withStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    
    NSDate *date = [self getDateFromTimeString:currentTime];
   
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    NSDate *dateNow = [self getNowDateFromatAnDate:date];
    NSDate *startNow = [self getNowDateFromatAnDate:start];
    NSDate *expireNow = [self getNowDateFromatAnDate:expire];
    
    if (([dateNow compare:startNow] == NSOrderedDescending || [dateNow compare:startNow] == NSOrderedSame) && ([dateNow compare:expireNow] == NSOrderedAscending || [dateNow compare:expireNow] == NSOrderedSame)) {
        return YES;
    }
    return NO;
}

//计算传入时间之前或之后一定范围的时间（以小时为单位）
+ (NSString *)getAllowDateTime:(NSString *)time allowRange:(NSInteger)range {
    
    NSDate *mydate = [self getDateFromTimeString:time];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:mydate];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour] + range;
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    
    if (hour>23) {
        day = day + 1;
        
        if (day>[self isAllDay:year andMonth:month]) {//应该判断月份
            day = 1;
            month = month + 1;
            
            if (month > 12) {
                month = 1;
                year = year + 1;
            }
        }
        hour = hour - 24;
    }
    
    if (hour < 0) {
        day = day - 1;
        
        if (day == 0) {
            
            month = month - 1;
            
            if (month == 0) {
                year = year - 1;
                month = 12;
                day = [self isAllDay:year andMonth:month];
            } else {
                day = [self isAllDay:year andMonth:month];
            }
        }
        hour = 24 + hour;
    }
    
    
    NSString *string = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",year,month,day,hour,minute,second];
    return string;
}

+ (NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}



//计算传入时间之前或之后一定范围的时间（以分钟为单位）
+ (NSString *)getAllowDateTime:(NSString *)time allowRangeWithMinute:(NSInteger)range {
    
    NSDate *mydate = [self getDateFromTimeString:time];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:mydate];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    minute = ((minute + 10)/10)*10 + range;
    NSInteger second = [components second];
    
    if (minute>59) {
        
        hour = hour + 1;
        
        if (hour > 23) {
            hour = 0;
            day = day + 1;
            
            if (day > [self isAllDay:year andMonth:month]) {//应该判断月份
                day = 1;
                month = month + 1;
                if (month > 12) {
                    month = 1;
                    year = year + 1;
                }
            }
        }
        minute = minute - 60;
    }
    
    if (minute < 0) {
        hour = hour - 1;
        
        if (hour == 0) {
            day = day - 1;
            
            if (day == 0) {
                month = month - 1;
                
                if (month == 0) {
                    year = year - 1;
                    month = 12;
                    day = [self isAllDay:year andMonth:month];
                    hour = 0;
                } else {
                    day = [self isAllDay:year andMonth:month];
                }
            } 
            hour = 24 + hour;
        }
        minute = (60 + minute);
    }
    
    NSString *string = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2ld",year,month,day,hour,minute,second];
    return string;
}


//时区转换
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

//Date转String
+ (NSString *)getStringFromDate:(NSDate *)aDate {
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
    [dateFormater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//需转换的格式
    NSString *dateStr = [dateFormater stringFromDate:aDate];
    return dateStr;
}


+ (int)compareDate:(NSString *)firstDate withDate:(NSString *)secondDate {
    int resultNumber;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dtFir = [[NSDate alloc] init];
    NSDate *dtSec = [[NSDate alloc] init];
    dtFir = [df dateFromString:firstDate];
    dtSec = [df dateFromString:secondDate];
    NSComparisonResult result = [dtFir compare:dtSec];
    switch (result)
    {
        //dtSec比dtFir大
        case NSOrderedAscending: resultNumber = 1;
            break;
        //dtSec比dtFir小
        case NSOrderedDescending: resultNumber = -1;
            break;
        //dtSec=dtFir
        case NSOrderedSame: resultNumber = 0;
            break;
        default:
            break;
    }
    return resultNumber;
}




+ (NSString *)getColorRandomStringWithNum:(NSInteger)num {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 16;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 6) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}













//获取今天时间
+ (NSString *)getCurrentTime
{
    NSDate *today = [NSDate date];
    NSString *date = [NSString stringWithFormat:@"%llu",(UInt64)([today timeIntervalSince1970]*1000)];
    return date;
}

+ (NSString *)timestampSwitchTime:(NSString *)timestamp andFormatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];//（@"YYYY-MM-dd HH:mm:ss"）hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSTimeInterval time = [timestamp doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}



//String转Date
+ (NSDate *)getDateFromString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeInterval time = [string doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    //NSDate *date = [dateFormat dateFromString:time];//Z是0时区
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: confromTimesp];
    NSDate *endDate = [confromTimesp dateByAddingTimeInterval: interval];
    return endDate;
}

//字典转json串
+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//json串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

//判断是否在一段时间之内
+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

+ (NSDate *)dateString:(NSString *)currentDate limit:(int)count
{
    NSDate *date;
    if (currentDate.length > 0 || currentDate != nil) {
        date = [self getDateFromString:currentDate];
    } else {
        date = [NSDate date];
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day] + count)];
    NSDate *endDate = [gregorian dateFromComponents:components];
    return endDate;
}

//签名MD5加密
+ (NSString *)MD5:(NSString *)sign
{
    const char *cStr = [sign UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//字典升序排列
+ (NSString *)parameSort:(NSDictionary *)dic
{
    NSMutableDictionary *dict = [dic mutableCopy];
    [dict removeObjectForKey:@"appid"];
    
    NSArray *keyArray = [dict allKeys] ;
    
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        
        NSString *str = [dic objectForKey:sortString];
        [valueArray addObject:[self urlencode:str]];
    }
    
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        
        NSString *keyValueStr = [NSString stringWithFormat:@"%@%@",sortArray[i],valueArray[i]];
        
        [signArray addObject:keyValueStr];
    }
    NSString *sign = [signArray componentsJoinedByString:@""];
    
    NSString *path = [NSString stringWithFormat:@"%@%@%@",sign,@"cig436a14108af32b3f",@"d45d4cfd364499ea890362f6ef86d12b"];
    
    return [NSString MD5:path];
}

//value URLEncode
+ (NSString *)urlencode:(NSString *)string {
    
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[string UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == '+'){
            [output appendFormat:@"%@", @" "];
        } else if ((thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%c", thisChar];
        }
    }
    return output;
}

//字符串网址检测
+ (NSString *)strUTF8Encoding:(NSString *)str {
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

//是否有效的HTTP
+ (BOOL)isValidHttpURL:(NSString *)httpurl
{
    NSString *urlRegEx =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:httpurl];
}

- (BOOL)isValidHttpURL
{
    NSString *urlRegEx =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

//是否是有效手机号
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,172,178,182,183,184,187,188,198
     * 联通：130,131,132,152,155,156,166,175,176,185,186
     * 电信：133,1349,153,173,177,180,181,189,199
     */
    //NSString * MOBILE = @"^1(3[0-9]|4[5-9]|5[0-35-9]|66|7[235-8]|8[0-9]|99)\\d{8}$";
    NSString * MOBILE = @"^1[^0,1,2]\\d{9}$";//与后台一致
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,172,178,182,183,184,187,188,198
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|7[28]|8[23478])|98\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,166,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|6[6]|7[56]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,173,177,180,181,189,199
     22         */
    NSString * CT = @"^1((33|53|7[37]|8[019]|99)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isValidPhoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,172,178,182,183,184,187,188,198
     * 联通：130,131,132,152,155,156,166,175,176,185,186
     * 电信：133,1349,153,173,177,180,181,189,199
     */
    //NSString * MOBILE = @"^13\\d{9}|14[5-9]\\d{8}|15[^4]\\d{8}|166\\d{8}|17[^1,4,9]\\d{8}|18\\d{9}|19[8,9]\\d{8}$";
    NSString * MOBILE = @"^1[^0,1,2]\\d{9}$";//与后台一致
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,172,178,182,183,184,187,188,198
     12         */
    NSString * CM = @"^13[^0,1,2,3]\\d{8}|15[^3,4,5,6]\\d{8}|17[2,8]\\d{8}|18[2,3,4,7,8]\\d{8}|19[8]\\d{8}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,166,175,176,185,186
     17         */
    NSString * CU = @"^1(30|31|32)\\d{8}|1(52|55|56)\\d{8}|166\\d{8}|17[5,6]\\d{8}|18[5,6]\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,173,177,180,181,189,199
     22         */
    NSString * CT = @"^1((33|73|77|53|8[0,1,9]|99)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//去掉电话中的特殊字符
- (NSString *)removeSpecialCharactersFromPhone:(NSString *)phone {
    phone = [phone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    return phone;
}

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c(GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s(GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7Plus";
    
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5Gen)";
    

    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceString;
}

+ (NSString *)getDeviceIPAddresses {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

/**
 *  URLDecode
 */
- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, CFSTR("")));
    return result;
}

@end
