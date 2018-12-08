//
//  UITabBar+bage.h
//  FlyClip
//
//  Created by 都兴忱 on 2017/2/6.
//  Copyright © 2017年 tongboshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (bage)
- (void)showBadgeOnItemIndex:(NSInteger)index unread:(NSString *)unreads;
- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点
@end
