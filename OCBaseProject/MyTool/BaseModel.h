//
//  BaseModel.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict;


@end

NS_ASSUME_NONNULL_END
