//
//  EmptyView.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyView : UIView

@property (nonatomic, strong) UIImageView   *imageV;      //    默认图。
@property (nonatomic, strong) UILabel       *label;       //    默认文字。

/// 上面一张图片，下面一行文字 , 传nil为不展示
- (void)image:(UIImage *)image labelString:(NSString *)labelString;

@end

NS_ASSUME_NONNULL_END
