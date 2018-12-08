//
//  MyBaseVC.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyView.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyBaseVC : UIViewController

@property (nonatomic, strong) EmptyView             *emptyView;         // 默认的空页面

/// 添加标题 - 通用的方法添加VC的标题，便于修改
- (void)addTitle:(NSString *)titleString;

- (void)rightButtonWithName:(NSString *)name image:(UIImage *)image block:(void(^)(UIButton *btn))block;



@end

NS_ASSUME_NONNULL_END
