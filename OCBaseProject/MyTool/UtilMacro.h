
//
//  UtilMacro.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h


#if DEBUG
///debug模式下-----------------Begin--------------------------
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
///release模式下---------------End--------------------------
#define NSLog(tmt, ...)
#endif

// 系统控件默认高度
#define kStatusBarHeight        (20.f + (IS_IPHONE_X?24.f:0))
#define kNavigationBarHeight    (64.0f + (IS_IPHONE_X?24.f:0))
#define kTabBarHeight           (49.f + (IS_IPHONE_X?34.f:0))
#define kViewBottomHeight       (IS_IPHONE_X?34.f:0)
/// 主屏的宽
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/// 主屏的高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// App 版本号. 1.0.0
#define APP_VERSION                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// App构建版本号 1
#define APP_BUILD_VERSION                  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#pragma mark - 设备判断
/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define IS_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhoneX 屏幕高度为812*/
#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height == 812 || [[UIScreen mainScreen] bounds].size.height == 896)

//----------------------ABOUT SYSTYM & VERSION 系统与版本 ----------------------------
#define SYSTEM_VERSION_STRING              [[UIDevice currentDevice] systemVersion]
#define SYSTEM_VERSION_FLOAT               [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)
/** 是否为iOS10 */
#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)
/** 是否为iOS11 */
#define iOS11 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) ? YES : NO)
/** 是否为iOS12 */
#define iOS12 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0) ? YES : NO)


#define kDegrees_To_Radian(x) (M_PI * (x) / 180.0)
#define kRadian_To_Degrees(radian) (radian*180.0)/(M_PI)
/// -----------------------------字符串、Number 保护-------------------------BEGIN
#define kSafe_Get_String(presence, key) \
([presence objectForKey: key] != nil && [presence objectForKey: key] != [NSNull null]) && [[presence objectForKey: key] isKindOfClass:[NSString class]] && ![[presence objectForKey: key] isEqualToString:@"null"] && ![[presence objectForKey: key] isEqualToString:@"<null>"] ? [presence objectForKey: key] : @"" \

#define kSaft_Get_Number(presence, key)  \
([presence objectForKey: key] != nil && [presence objectForKey: key] != [NSNull null]) ? [presence objectForKey: key] : @0 \
/// -----------------------------字符串、Number 保护-------------------------END
#pragma mark - 字体
// Helvetica - 最常用 - ios9以上用 平方字体，iOS9以下用 Helvetica字体
// 但是字体：PingFangSC-Regular iOS9之后才有呢
#define FONT_Helvetica(F) (iOS9 ? [UIFont fontWithName: @"PingFangSC-Regular" size: F] : [UIFont fontWithName: @"Helvetica" size: F])
#define FONT_Helvetica_BOLD(F) (iOS9 ? [UIFont fontWithName: @"PingFangSC-Semibold" size: F] : [UIFont fontWithName: @"Helvetica-bold" size: F])


#pragma mark - 语言相关

// Locale String [Upper Case]
// 英文-香港    EN_HK
// 中文-香港    ZH_HK
// 英文-中国    EN_CN
// 英文-台湾    EN_TW
// 英文-澳门    EN_MO
#define LOCALE_STRING_UPPER_CASE     [(NSString *)[[NSLocale currentLocale] localeIdentifier] uppercaseString]

//
// zh           中文
// zh-Hant      繁体中文
// zh-Hans      简体中文
// zh-HK        繁体中文(香港)
#define I18N_CURRENT_LANGUAGE_STRING (([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]))

// 语言是否是中文。中文：YES 其他语言：NO
#define kLanguage_Is_Chinese          ([([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]) hasPrefix:@"zh"])

#define kLanguage_Is_English          ([([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]) hasPrefix:@"en"])

//
// 该宏用户判断是否处于国际化模式下，即非中文模式；
// 该宏的判断逻辑可以使用语言来判是否需要进行国际化，包括单位转换等；
// 在非中国的海外地区
//
#define kArea_Out_China \
(!([LOCALE_STRING_UPPER_CASE hasSuffix:@"CN"] ||    \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"HK"] ||   \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"TW"] ||   \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"MO"]))

//非中国大陆或者香港的话是用苹果地图。。。。
#define kArea_Out_China_Neidi \
(!([LOCALE_STRING_UPPER_CASE hasSuffix:@"CN"] ||    \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"HK"]))







#endif /* UtilMacro_h */
