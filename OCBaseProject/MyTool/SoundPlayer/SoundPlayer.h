//
//  SoundPlayer.h
//  niaoyutong
//
//  Created by zhangmingwei on 2017/5/10.
//  Copyright © 2017年 niaoyutong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kNotificationSoudDidStop            @"kNotificationSoudDidStop"

typedef enum {
    LanguageTypeChinese     =   1,
    LanguageTypeEnglish     =   2,
    LanguageTypeJp          =   3,  //日文
}LanguageType;

@interface SoundPlayer : NSObject

@property(nonatomic, assign) float rate;   //语速
@property(nonatomic, assign) float volume; //音量
@property(nonatomic, assign) float pitchMultiplier;  //音调
@property(nonatomic, assign) BOOL  autoPlay;  //自动播放

//类方法实例出对象
+ (SoundPlayer *)defaltManager;

//播放并给出文字
- (void)play:(NSString *)string languageType:(LanguageType)lanType;
/// 停止播放声音
- (void)stopAction;
@end
