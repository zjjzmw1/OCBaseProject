//
//  MyBaseVC.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "MyBaseVC.h"


@interface MyBaseVC ()

@end

@implementation MyBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认导航栏显示
    self.fd_prefersNavigationBarHidden = NO; // 隐藏的话，需要在具体的VC的viewDidLoad里面设置为YES
    self.navigationController.navigationBar.translucent = NO;
    // 禁止某个页面的滑动返回：在viewWillappear里面设置：
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //    self.fd_interactivePopDisabled = YES; // 加上这句才OK。
    // 在viewwillDisappear设置：
    //    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //    self.fd_interactivePopDisabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 默认展示导航栏下面的横线
    [self showNavigationBottomLine];
    
    // 最上层。
    [self initEmptyView];
}

#pragma mark - 默认空页面
- (void)initEmptyView {
    self.emptyView = [[EmptyView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.emptyView];
    self.emptyView.hidden = YES;
    [self.emptyView image:[UIImage imageNamed:@""] labelString:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc {
    NSLog(@"页面：（%@）销毁了",[[self class] description]);
}

- (void)showNavigationBottomLine{
    //将去掉的navigation底边的横线调回
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor getNavigationBarColor];
}

- (void)hideNavigationBottomLine{
    //去掉navigation底边的横线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
}

/**
 *  导航栏左边按钮  重写返回按钮
 *
 *  @param name        按钮名称
 *  @param image       按钮图片
 *  @param block       返回导航栏左边按钮
 */
- (void)leftButtonWithName:(NSString *)name image:(UIImage *)image block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
    }
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 0;// 值越大越靠左边
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮
 *
 *  @param name        按钮名称
 *  @param image       按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithName:(NSString *)name image:(UIImage *)image block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    if (![NSString isEmptyString:name]) {
        [button.titleLabel sizeToFit];
        [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    }else{
        [button setFrame:CGRectMake(0, 0, 60, 44)];// 太大的话，影响title
    }
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮---靠右边的(点击事件小，在titleView太长的时候正好有个按钮和rightBtn太近的时候用的)
 *
 *  @param name        按钮名称
 *  @param image       按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithNameRight:(NSString *)name image:(UIImage *)image block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 80, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (!image) {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    if (![NSString isEmptyString:name]) {
        [button.titleLabel sizeToFit];
        [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    } else {
        [button setFrame:CGRectMake(0, 0, 40, 44)];// 太大的话，影响title
    }
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮 自己传入自定义的view 给右按钮
 *
 *  @param view        自定义按钮
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithView:(UIView *)view block:(void(^)(UIView *view))block{
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    __weak typeof(view) weakView = view;
    [view setTapActionWithBlock:^{
        block(weakView);
    }];
}

/// 获取当前控制器，把UIViewController替换为需要的控制器就OK了
- (UIViewController *)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
/// 获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

/// 添加标题 - 通用的方法添加VC的标题，便于修改
- (void)addTitle:(NSString *)titleString {
    //    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    //    titleLab.text = titleString;
    //    titleLab.textAlignment = NSTextAlignmentCenter;
    //    titleLab.textColor = [UIColor blackColor];
    //    titleLab.font = FONT_Helvetica_BOLD(18);
    //    titleLab.font = FONT_Helvetica(18);
    self.navigationItem.title = titleString;
}

@end
