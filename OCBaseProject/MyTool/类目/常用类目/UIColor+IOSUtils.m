//
//  UIColor+IOSUtils.m
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import "UIColor+IOSUtils.h"

@implementation UIColor (IOSUtils)

#pragma mark - Color from Hex
+ (instancetype)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

+ (instancetype)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:alpha];
}

#pragma mark - RGBA Helper method
+ (instancetype)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [[self class] colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

/**
 获取标题的字体颜色 262626 - 黑
 
 @return
 */
+ (UIColor *)getTitleColor {
    return [UIColor colorFromHexString:@"262626"];
}

/**
 获取默认页面背景色 #ffffff

 @return
 */
+ (UIColor *)getBackgroundColor {
    return [UIColor colorFromHexString:@"ffffff"];
}

/**
 获取表格分割线的颜色 cccaca - 淡淡的黑

 @return
 */
+ (UIColor *)getSeparatorColor {
    return [UIColor colorFromHexString:@"cccaca"];
}

/**
 获取内容的字体颜色 6b6b6b - 二级黑
 
 @return
 */
+ (UIColor *)getContentColor {
    return [UIColor colorFromHexString:@"6b6b6b"];
}
/**
 获取次级内容的字体颜色 aaaaaa - 最浅的黑  ----- 也可以作为按钮不可点击的颜色
 
 @return
 */
+ (UIColor *)getContentSecondColor {
    return [UIColor colorFromHexString:@"aaaaaa"];
}

/**
 获取默认文字颜色。placeHoler的颜色 cccaca
 
 @return
 */
+ (UIColor *)getPlaceHoderColor {
    return [UIColor colorFromHexString:@"cccaca"];
}
/**
 获取导航栏的背景颜色

 @return fcfcfc
 */
+ (UIColor *)getNavigationBarColor {
    return [UIColor colorFromHexString:@"fcfcfc"];
}

/**
 获取统一的蓝色的背景颜色
 
 @return blue
 */
+ (UIColor *)getBlueColor {
    return [UIColor blueColor];
}

/// 黄色
+ (UIColor *)getYellowColor {
    return [UIColor colorFromHexString:@"#F6C358"];
}

/// 红色
+ (UIColor *)getRedColor {
    return [UIColor colorFromHexString:@"#E86960"];
}

/// 紫色
+ (UIColor *)getPurpleColor {
    return [UIColor colorFromHexString:@"#7D5D9E"];
}

/// 绿色
+ (UIColor *)getGreenColor {
    return [UIColor colorFromHexString:@"#61C355"];
}

/**
 获取输入框的光标颜色 blackColor

 @return 黑色
 */
+ (UIColor *)getTextFieldCursorColor {
    return [UIColor blackColor];
}

@end
