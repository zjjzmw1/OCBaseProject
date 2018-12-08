//
//  UITabBar+bage.m
//  FlyClip
//
//  Created by 都兴忱 on 2017/2/6.
//  Copyright © 2017年 tongboshu. All rights reserved.
//

#import "UITabBar+bage.h"

@implementation UITabBar (bage)
//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index unread:(NSString *)unreads{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.textColor = [UIColor whiteColor];
    badgeView.text = unreads;
    badgeView.font = [UIFont systemFontOfSize:12];
    badgeView.textAlignment = NSTextAlignmentCenter;
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 13.0;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    CGFloat percentX = (index + 0.6) / 5.0; // 5个tabbar
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x-4, y-4, 34, 26);//圆形大小为10
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];
}
-(CGSize)sizeWithString:(NSString *)str
                  fount:(UIFont*)fount
                maxSize:(CGSize)size {
    
    CGRect rect = [str boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                 attributes:@{NSFontAttributeName:fount}
                                    context:nil];
    return rect.size;
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
