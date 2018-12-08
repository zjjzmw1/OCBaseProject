//
//  UIImageView+IOSUtils.h
//  FlyClip
//
//  Created by zhangmingwei on 2017/11/27.
//  Copyright © 2017年 tongboshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (IOSUtils)

/**
 *  获取常用的 UIImageView  默认：UIViewContentModeScaleAspectFill;     ///这个是取中间的一部分。。不压缩的。
 *
 *  @param frame 设置圆角的时候需要
 *
 *  @return UIImageView
 */
+ (UIImageView *)getImageViewFrame:(CGRect)frame;

@end
