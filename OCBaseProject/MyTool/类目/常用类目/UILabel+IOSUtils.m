//
//  UILabel+IOSUtils.m
//  FlyClip
//
//  Created by zhangmingwei on 2017/11/27.
//  Copyright © 2017年 tongboshu. All rights reserved.
//

#import "UILabel+IOSUtils.h"

@implementation UILabel (IOSUtils)

/**
 *  获取常用的UILabel
 *
 *  @param font      UIFont
 *  @param textColor UIColor
 *
 *  @return UILabel
 */
+ (UILabel *)getLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc]init];
    if (font) {
        label.font = font;
    }
    label.textAlignment = NSTextAlignmentLeft; // 默认的左对齐
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

@end
