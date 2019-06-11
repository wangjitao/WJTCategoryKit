//
//  UIView+Utilities.m
//  OfficeSystem
//
//  Created by wangjt on 2017/7/3.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "UIView+Utilities.h"
#include <objc/runtime.h>
#import <UIKit/UIKit.h>
const static  void *BadgeLableString =&BadgeLableString;

@interface BadgeLable : UILabel
{
    UIColor  *m_pTextClolor;         //字体颜色
    UIColor  *m_pBackGroundClolor;   //背景颜色
    UIFont   *m_pLableFont;          //字体大小
    CGSize    m_CMinSize;             //最小大小
    NSTextAlignment m_tTextAlignment; //对齐方式
}

@end

@implementation BadgeLable

-(instancetype)init{
    
    if (self=[super init]) {
        
        m_pTextClolor=[UIColor whiteColor];
        m_pBackGroundClolor=[UIColor redColor];
        //m_pLableFont=[UIFont systemFontOfSize:10];
        m_CMinSize = CGSizeMake(10, 10);
        m_tTextAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)makeBrdgeViewWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                   backColor:(UIColor *)backGColor
                    textFont:(UIFont *)font
                      tframe:(CGRect )frame{
    
    if (text.length==0) {
        
        CGFloat x_margin=frame.size.width - 13.5;
        CGFloat y_margin=frame.size.height - 13.5;
        self.frame = CGRectMake(frame.origin.x+x_margin*0.5, frame.origin.y+y_margin*0.5, 12, 12);
    
    } else {
        self.frame = frame;
    }
    self.backgroundColor=backGColor;
    self.textColor=textColor;
    self.font=font;
    self.text=text;
    self.textAlignment=m_tTextAlignment;
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frame.size.height*0.5;
    m_pTextClolor=textColor;
    m_pBackGroundClolor=backGColor;
    m_pLableFont=font;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view==self) {
        return self.superview;
    }
    return [super hitTest:point withEvent:event];
}

@end

@implementation UIView (Utilities)

- (UIImage *)toImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImageView *)toImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self toImage]];
    imageView.frame = self.frame;
    return imageView;
}

- (void)roundCorners {
    self.layer.cornerRadius = 8.0f;
}

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
    self.frame = CGRectMake(newX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
    self.frame = CGRectMake(self.frame.origin.x, newY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

- (CGFloat)boundsX {
    return self.bounds.origin.x;
}

- (void)setBoundsX:(CGFloat)newX {
    self.bounds = CGRectMake(newX, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsY {
    return self.bounds.origin.y;
}

- (void)setBoundsY:(CGFloat)newY {
    self.bounds = CGRectMake(self.bounds.origin.x, newY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)newWidth {
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, newWidth, self.bounds.size.height);
}

- (CGFloat)boundsHeight {
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)newHeight {
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, newHeight);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newX {
    self.center = CGPointMake(newX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newY {
    self.center = CGPointMake(self.center.x, newY);
}


#pragma mark - 添加消息提醒
- (void)addBadge
{
    if ([self BadgeLable] == nil) {//如果没有绑定就重新创建,然后绑定
        BadgeLable *badgeLable =[[BadgeLable alloc] init];
        objc_setAssociatedObject(self, BadgeLableString, badgeLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:badgeLable];
    }
}

- (void)showBadgeText:(NSString *)text
{
    [self addBadge];
    
    [self BadgeLable].hidden = NO;
    
    [self makeBadgeText:text
              textColor:[UIColor whiteColor]
              backColor:[UIColor redColor]
                   Font:[UIFont systemFontOfSize:14]];
}

- (void)makeBadgeText:(NSString *)text
            textColor:(UIColor *)tColor
            backColor:(UIColor *)backColor
                 Font:(UIFont*)tfont {
    
    CGSize textSize = [self sizeWithString:text
                                    font:tfont
                      constrainedToWidth:self.frame.size.width];
    
    if ([self isKindOfClass:[UIButton class]]) {
        
        UIButton *weakButton=(UIButton*)self;
        [[self BadgeLable] makeBrdgeViewWithText:text
                                       textColor:tColor
                                       backColor:backColor
                                        textFont:tfont
                                          tframe:CGRectMake(weakButton.imageView.frame.size.width*0.5+weakButton.imageView.frame.origin.x,weakButton.imageView.frame.origin.y, textSize.width+8.0, textSize.height)];
        
    } else if ([self isKindOfClass:[UITabBarItem class]]){
        
        
        
    } else if ([self isKindOfClass:[UIImageView class]]){
        
        UIImageView *weakImageV = (UIImageView *)self;
        [[self BadgeLable] makeBrdgeViewWithText:text
                                       textColor:tColor
                                       backColor:backColor
                                        textFont:tfont
                                          tframe:CGRectMake(weakImageV.frame.size.width-(textSize.width + 13.5 + 8)*1, textSize.height*.02, textSize.width + 4, textSize.height)];
    } else {
    
    }
}

- (void)hiddenBadgeView
{
    [self BadgeLable].hidden = YES;
}

- (BadgeLable *)BadgeLable {
    
    BadgeLable *badgeLable = objc_getAssociatedObject(self, BadgeLableString);
    return badgeLable;
}

#pragma mark sizeLableText
- (CGSize)sizeWithString:(NSString *)string
                    font:(UIFont *)font
      constrainedToWidth:(CGFloat)width
{
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:(NSStringDrawingUsesLineFragmentOrigin |
                                                 NSStringDrawingTruncatesLastVisibleLine)
                                     attributes:attributes
                                        context:nil].size;
    } else
    {
        textSize = [string sizeWithFont:textFont
                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:(NSStringDrawingUsesLineFragmentOrigin |
                                             NSStringDrawingTruncatesLastVisibleLine)
                                 attributes:attributes
                                    context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    
}


@end
