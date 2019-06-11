//
//  CIGUtility.h
//  MrCarDriver
//
//  Created by wjt on 2018/8/6.
//  Copyright © 2018年 izuche Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Utility : NSObject

+ (UIViewController *)topViewController;

+ (NSMutableAttributedString *)attributedString:(NSString *)content
                                       fontSize:(CGFloat)fontSize
                                    lineSpacing:(CGFloat)spacing;
//获取字符串的对应高度
+(CGSize)sizeWithString:(NSString *)string
                   font:(CGFloat)font
               maxWidth:(CGFloat)maxWidth;

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text
                     height:(CGFloat)height
                       font:(CGFloat)font;

//富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text
                                          rangeText:(NSString *)rangeText
                                          textColor:(UIColor *)color
                                           fontSize:(CGFloat)fontSize;

//可调用的第三方地图
+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation;

//判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable;



@end
