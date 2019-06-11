//
//  MotorcadeDispatchStateView.m
//  MotorcadeApp
//
//  Created by Superman on 2019/5/20.
//  Copyright © 2019 izuche Co.,Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (SAdd)

/**
 *  UIView扩展的一些属性 用于对其frame的操作
 */
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

/**从xib加载视图**/
+ (instancetype)viewFromXib;

-(void)addBottomLine;
@end
