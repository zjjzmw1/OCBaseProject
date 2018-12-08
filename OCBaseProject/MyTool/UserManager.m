//
//  UserManager.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)defaultManager {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 只能执行一次：这里是单利属性的初始化。
        
    }
    return self;
}


@end
