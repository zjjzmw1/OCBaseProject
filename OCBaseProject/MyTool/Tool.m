//
//  Tool.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "Tool.h"
#import <AVFoundation/AVFoundation.h>
#import "BaseModel.h"

@implementation Tool

/// 从本地获取Model的数据
+ (NSMutableArray *)getModelArray:(NSString *)modelArrayKey {
    NSMutableArray *lastArr = [NSMutableArray array];
    // 获取
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lastKeyStr = [NSString stringWithFormat:@"voiceMemo/%@.txt",modelArrayKey];
    NSString *CachePath = [lastKeyStr stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *filename = [Path stringByAppendingPathComponent:CachePath];
    NSData *readData = [[NSData alloc]initWithContentsOfFile:filename];
    if (readData) {
        NSArray *readArr = [NSJSONSerialization JSONObjectWithData:readData options:NSJSONReadingAllowFragments error:nil];
        if (readArr.count > 0) {
            [lastArr addObjectsFromArray:readArr];
        }
    }
    
    // 把获取到的数组，包装下，返回。
    NSMutableArray *lastModelArr = [NSMutableArray array];
    if (lastArr.count > 0) {
        for (int i = 0; i < lastArr.count; i++) {
            NSDictionary *dict = lastArr[i];
            if (dict && dict.count > 0) {
                BaseModel *model = [BaseModel initWithDictionary:dict];
                if (model) {
                    [lastModelArr addObject:model];
                } else {
                    [lastModelArr addObject:dict];
                }
            }
        }
    }
    return  lastModelArr;
}

/// 保存Model到本地 --- model数组，普通的数组都可以保存
+ (void)saveModelArray:(NSArray *)arr modelArrayKey:(NSString *)modelArrayKey {
    // 存放json的数组
    NSMutableArray *jsonArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        BaseModel *model = arr[i];
        if (model) {
            [jsonArr addObject:model.modelToJSONObject];
        }
    }
    // 如果传来的不是model，就直接保存数组。
    NSMutableArray *lastArr = [NSMutableArray arrayWithArray:arr];
    if (jsonArr.count > 0) {
        lastArr = [NSMutableArray arrayWithArray:jsonArr];
    }
    NSString *jsonStr = [Tool toJSONString:lastArr];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *lastKeyStr = [NSString stringWithFormat:@"voiceMemo/%@.txt",modelArrayKey];
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [lastKeyStr stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *filename = [Path stringByAppendingPathComponent:CachePath];
    NSLog(@"saveKey===%@",filename);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filename]) {
        if (![fileManager createFileAtPath:filename contents:nil attributes:nil]) {
            NSLog(@"createFile error occurred");
        }
    }
    if ([jsonData writeToFile:filename atomically:YES]) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
    
}

+(NSString *)toJSONString:(NSArray *)arr {
    NSString *jsonStr = @"";
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    if (data) {
        jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}

/**
 *  设置statusBar颜色是否是白色的
 *
 *  @param isWhiteColor YES:白色、NO:黑色
 */
+ (void)setStatusBarTitleColorIsWhiteColor:(BOOL)isWhiteColor {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if (isWhiteColor) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

#pragma mark - 获取UILabel的多行的size
+ (CGSize)getLabelSize:(UILabel *)label labelWidth:(float)width {
    //    // 把UILabel放到ScrollView的上面的时候需要这个属性
    //    self.bigTextLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*2;
    NSString *contentString = [label.text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(width, width * 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: label.font } context:nil].size;
    return size;
}

#pragma mark - 判断当前页面是否正在显示
+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController {
    return (viewController.isViewLoaded && viewController.view.window);
}

#pragma mark - 跳转到指定页面
+ (void)jumpToVC:(NSString *)vcNameString fromVC:(UIViewController *)vc {
    for (int i = 0; i < vc.navigationController.viewControllers.count; i++) {
        if ([vc.navigationController.viewControllers[i]
             isKindOfClass:NSClassFromString(vcNameString)]) {
            [vc.navigationController popToViewController:vc.navigationController.viewControllers[i] animated:YES];
            return;
        }
    }
    [vc.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取当前navigationController.viewControllers里面的某一个VC
+ (UIViewController *)getViewControllerWithName:(NSString *)vcNameString fromVC:(UIViewController *)vc {
    for (int i = 0; i < vc.navigationController.viewControllers.count; i++) {
        if ([vc.navigationController.viewControllers[i]
             isKindOfClass:NSClassFromString(vcNameString)]) {
            return vc.navigationController.viewControllers[i];
        }
    }
    return nil;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [Tool getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [Tool getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [Tool getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 播放震动
+ (void)playVibration {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);// 播放震动
}
/// 停止震动
+ (void)stopVibration {
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate); // 停止震动
}

/// 设置声音变小 - 录音的时候需要小
+ (void)volumeLittle {
    AVAudioSession *session = [AVAudioSession sharedInstance]; // 小
    if (![session.category isEqualToString:AVAudioSessionCategoryPlayAndRecord]){
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [session setActive:YES error:nil];
    }
}

/// 设置声音变大 - 播放声音的时候需要大
+ (void)volumeBig {
    AVAudioSession *session = [AVAudioSession sharedInstance]; // 大
    if (![session.category isEqualToString:AVAudioSessionCategoryPlayback]){
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
    }
}

/// 跳转到系统的设置页面
+ (void)goSetting {
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

/// 保证一个方法在0.5秒内不能重复调用
+ (BOOL)repeatCallAction:(NSString *)funcName {
    static NSDate *now = nil;
    static NSString *funcStr = nil;
    if (![funcStr isEqualToString:funcName]) { // 如果调用的方法不是一个，就重写给now赋值
        now = nil;
    }
    if (!now) {
        now = [NSDate dateWithTimeIntervalSinceNow:-0.6]; // 第一次赋值当然是不能被拦截的。
    }
    if ([[NSDate dateWithTimeIntervalSinceNow:-0.5] compare:now] != kCFCompareGreaterThan) { // 比之前保存的时候小就拦截
        NSLog(@"频繁调用%@被拦截了",funcName);
        return YES; // 0.5秒内不能重复调用这个方法
    }
    NSLog(@"调用%@",funcName);
    now = [NSDate date];
    funcStr = funcName;
    return NO;
}

///// 统计进入页面的方法
//+ (void)beginLogPageView:(NSString *)title {
//    // 友盟统计页面进入
//    [MobClick beginLogPageView:title];
//}
///// 统计离开页面的方法
//+ (void)endLogPageView:(NSString *)title {
//    // 友盟统计页面离开
//    [MobClick endLogPageView:title];
//}
//
///// 友盟的点击事件
//+ (void)event:(NSString *)eventId {
//    // 友盟的事件点击按钮
//    [MobClick event:eventId];
//}
//
///// 友盟的点击事件-带Label的
//+ (void)event:(NSString *)eventId label:(NSString *)labelString {
//    // 友盟的事件点击按钮
//    [MobClick event:eventId label:labelString];
//}

#pragma mark - 统一调用所有的提示的提示框
/**
 统一提示信息。（防止更换提示的样式甚至控件，所有在这里封装一下）
 @param tipString 提示文字
 */
+ (void)showTip:(NSString *)tipString {
    [ProgressHUD showTitle:tipString]; // 简单的提示一句话
    // 万一有一天更换为MBProgress了。就改这一个地方就OK了。
}


@end

