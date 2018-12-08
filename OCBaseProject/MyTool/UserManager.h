//
//  UserManager.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

/// 当前登录账号的token
@property (nonatomic, copy) NSString        *accountToken;
/// 当前登录账号的 sessionid
@property (nonatomic, copy) NSString        *accountSessionId;

+ (instancetype)defaultManager;

@end

NS_ASSUME_NONNULL_END
