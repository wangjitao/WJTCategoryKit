//
//  DefaultValueMacro.h
//  InternationalAlliance
//
//  Created by wjt on 2018/6/19.
//  Copyright © 2018年 GINEA Co.,Ltd. All rights reserved.
//

#ifndef DefaultValueMacro_h
#define DefaultValueMacro_h

#define kJPUSHChannel     @"App Store"//程序包的下载渠道
#define kJPUSHDeviceId    @"motorcade_jpush_device_id"
#define kJPUSHDeviceToken @"motorcade_jpush_device_token"
#define kSYSTEMPUSHSTATUS @"motorcade_system_pushStutas"


#define kMCUser           @"motorcade_user"
#define kMCUserEnterprise @"motorcade_user_enterprise"
#define kMCUserMenuList   @"motorcade_user_menulist"


#define KCarTypeArr       @"motorcade_approve_carType"



#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//系统版本
#define KSystemVersion      ([[UIDevice currentDevice].systemVersion integerValue])

//机型
#define  iPhone4            (kScreenHeight == 480.0f)
#define  iPhone5            (kScreenHeight == 568.0f)
#define  iPhone6            (kScreenHeight == 667.0f)
#define  iPhone_plus        (kScreenHeight == 736.0f)
#define  iPhone_X           (kScreenHeight == 812.0f)


//比例函数
#define kScreenWidthRatio           (kScreenWidth / 375.0)
#define kScreenHeightRatio          (kScreenHeight / 667.0)
#define AdaptedWidthValue(x)        (ceilf((x) * kScreenWidthRatio))
#define AdaptedHeightValue(x)       (ceilf((x) * kScreenHeightRatio))

//通用屏幕尺寸
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kDeviceWidth    ([[UIDevice currentDevice] screenWidth])
#define kDeviceHeight   ([[UIDevice currentDevice] screenHeight])
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size): NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size): NO)

#define kDeviceIsiPhoneXLater   ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 1 : 0)

#define kStatusBarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
#define kNavBarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define kTabbarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
#define kSafeBottomHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.0 : 0.0)

//#define kDeviceIsiPhoneX                            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436),[[UIScreen mainScreen] currentMode].size) : NO)
//#define kStatusBarHeight                            (kDeviceIsiPhoneX ? 44 : 20)
//#define kStatusBarHeighterThanCommon                (kDeviceIsiPhoneX ? 24 : 0)

//#define kNavBarHeight   (kDeviceIsiPhoneX ? 88 : 64)
//#define kTabbarHeight   (kDeviceIsiPhoneX ? (49.f + 34.f) : 49.f)
//#define kSafeBottomHeight   (kDeviceIsiPhoneX ? 34.f : 0.f)

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)       [UIFont systemFontOfSize:FONTSIZE]

//默认灰背景
#define kDefaultViewColor          0xf6f6f8
#define kBlackestColor             0x333333
#define kBlackMiddleColor          0x666666
#define kBlackColor                0x999999
#define kWhiteColor                0xffffff
#define kHUDBackGroundColor        0x333333
#define kDefaultBlueColor          0x5988ff
#define kSeparatLineColor          0xdddddd
#define kDefaultRedColor           0xe72418

//报警模块
#define AlarmButtonColor           0x5988ff  //cell边框、悬浮窗按钮颜色
#define GrayColor                  0x666666
#define LightGrayColor             0xdddddd

#define LineGrayColor             0xe4e4e4
#define LineBlackColor            0xa09fa3


//审批
#define approverBgColor            0xf2f2f2
#define approverTextColor          0xbbbbbb
#define applyWaitStateColor        0x5988ff
#define applyStateColor            0x66d770
#define applyRejectStateColor      0xf5a623

#define lowerRank                  0xacc4ff




#define kContactTelephoneNum     @"10105678"

#define kOvertimeConnection      @"请求超时，请重试"
#define kNetConnectError         @"当前网络不可用，请检查你的网络设置"
#define kServerConnectError      @"服务器响应出错，请稍后重试"

#define kVehicleGPSErrorMsg      @"未获取到设备位置信息"
#define kVehicleSetFnsErrorMsg   @"未获取到设备位置信息,暂不能设置频率"
#define kVehicleShowHisErrorMsg  @"未获取到设备位置信息,无法展示轨迹"

#define kTimeNotInRangeErrorMsg  @"请选择四小时之内的时间"
#define kBeginEquEndErrorMsg     @"结束时间应大于开始时间"

/*
 订单状态；
 2：调度中；5：已过期；6：司机未出发；7:已取消；
 8:司机已出发；9：司机已到达；10：行程中；
 11：(行程结束)费用补录中；12：待结算；13：已完成
 */
#define StatusInDispatch     @"调度中"
#define StatusDispatched     @"调度成功"
#define StatusExpired        @"已过期"
#define StatusDNS            @"司机未出发"
#define StatusCanceled       @"已取消"
#define StatusDepart         @"司机已出发"
#define StatusDeparture      @"司机前往出发地"
#define StatusIn             @"司机已到达"
#define StatusAboard         @"乘客已上车"
#define StatusWaitAboard     @"等待乘客上车"
#define StatusBilling        @"开始计费"
#define StatusEnRoute        @"行程中"
#define StatusEndRoute       @"行程已结束"
#define StatusAddRecord      @"费用补录中"
#define StatusUnAccount      @"待结算"
#define StatusCompleted      @"订单已完成"




//未查询到此时间段设备信息
//请先选择时间

#define kNewVersionUpdate        @"新版本更新"
#define kForceUpdate             @"强制更新"


//获取View的属性
#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y

#define Notification_NotReachable  @"Notification_NotReachable"
#define Notification_Apns_Message  @"Notification_Apns_Message"


#endif /* DefaultValueMacro_h */
