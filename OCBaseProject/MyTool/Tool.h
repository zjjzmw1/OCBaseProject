//
//  Tool.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject

/// 从本地获取Model的数据 -- 可以是普通数组，model数组都OK
+ (NSMutableArray *)getModelArray:(NSString *)modelArrayKey;
/// 保存Model到本地 - 可以是普通数组和model数组都OK
+ (void)saveModelArray:(NSArray *)arr modelArrayKey:(NSString *)modelArrayKey;
/// 转换数组到jsonStr
+(NSString *)toJSONString:(NSArray *)arr;

/**
 *  设置statusBar颜色是否是白色的
 *
 *  @param isWhiteColor YES:白色、NO:黑色
 */
+ (void)setStatusBarTitleColorIsWhiteColor:(BOOL)isWhiteColor;

/// - 获取UILabel的多行的size
+ (CGSize)getLabelSize:(UILabel *)label labelWidth:(float)width;

/// 判断当前页面是否正在显示
+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

/// - 跳转到指定页面
+ (void)jumpToVC:(NSString *)vcNameString fromVC:(UIViewController *)vc;

/// - 获取当前navigationController.viewControllers里面的某一个VC
+ (UIViewController *)getViewControllerWithName:(NSString *)vcNameString fromVC:(UIViewController *)vc;
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

/// 播放震动
+ (void)playVibration;
/// 停止震动
+ (void)stopVibration;
/// 设置声音变小 - 录音的时候需要小
+ (void)volumeLittle;
/// 设置声音变大 - 播放声音的时候需要大
+ (void)volumeBig;
/// 跳转到系统的设置页面
+ (void)goSetting;
/// 保证一个方法在0.5秒内不能重复调用
+ (BOOL)repeatCallAction:(NSString *)funcName;

/**
 统一提示信息。（防止更换提示的样式甚至控件，所有在这里封装一下） 很快就自动消失
 @param tipString 提示文字
 */
+ (void)showTip:(NSString *)tipString;


@end

NS_ASSUME_NONNULL_END
