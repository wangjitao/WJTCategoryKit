//
//  MCNavigationItemCustomView.m
//  MrCarEnterprise
//
//  Created by wjt on 2018/9/27.
//  Copyright © 2018年 izuche Co.,Ltd. All rights reserved.
//

#import "MCNavigationItemCustomView.h"

@implementation MCNavigationItemCustomView


- (UIEdgeInsets)alignmentRectInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(self.alignmentRectInsetsOverride, UIEdgeInsetsZero)) {
        return super.alignmentRectInsets;
    } else {
        return self.alignmentRectInsetsOverride;
    }
    
}

@end
