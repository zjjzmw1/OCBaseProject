//
//  UIView+CodeFragments.h
//  CodeFragment
//
//  Created by jinyu on 15/2/4.
//  Copyright (c) 2015年 jinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CodeFragments)

typedef enum {
    ShadowColorBlack        =   0,      // 存黑色阴影用于：表格、等大view
    ShadowColorLight        =   1,      // 浅色阴影用于：小按钮。
}ShadowColor;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;

@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;

- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;

/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners;

/**
 *  给View添加黑色阴影和圆角 - 四个边都有阴影
 *
 *  @param shadowColor      阴影颜色
 *  @param corner           view的圆角
 */
- (void)addShadowWithColor:(ShadowColor)shadowColor corner:(float)corner;

- (UIImage *)snapsHotView;

@end
