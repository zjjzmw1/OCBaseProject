//
//  UITableView+IOSUtils.h
//  ZMWOCFramework
//
//  Created by zhangmingwei on 2017/12/12.
//  Copyright © 2017年 zhangmingwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (IOSUtils)

/**
 初始化表格方便的方法 -- 方便统一修改表格的属性
 
 @param frame 大小、位置
 @return 表格
 */
+ (UITableView *)getTableView:(CGRect)frame;

@end
