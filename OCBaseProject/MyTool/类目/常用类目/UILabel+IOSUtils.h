//
//  UILabel+IOSUtils.h
//  FlyClip
//
//  Created by zhangmingwei on 2017/11/27.
//  Copyright © 2017年 tongboshu. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UILabel (IOSUtils)

/**
 *  获取常用的 UILabel --- 默认左对齐
 *
 *  @param font      UIFont
 *  @param textColor UIColor
 *
 *  @return UILabel
 */
+ (UILabel *)getLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

@end
