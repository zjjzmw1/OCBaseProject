//
//  HomeVC.m
//  OCBaseProject
//
//  Created by zhangmingwei on 2018/12/8.
//  Copyright © 2018 xiaoming. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"首页"];
    self.view.backgroundColor = [UIColor getGreenColor];
    
    [self.emptyView image:nil labelString:@"暂无数据"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.emptyView setHidden:YES];
    
}


@end
