//
//  NSData+Utilities.h
//  OfficeSystem
//
//  Created by wangjt on 2017/3/8.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Utilities)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end
