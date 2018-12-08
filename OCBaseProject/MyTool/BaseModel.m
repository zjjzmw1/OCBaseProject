//
//  BaseModel.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

/**
 根据字典返回model
 
 @param dict 字典
 @return model
 */
+ (instancetype)initWithDictionary:(NSDictionary*)dict {
    return [BaseModel modelWithDictionary:dict];
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    // - 字段和后台不同的时候需要在这里设置 前面是model的，后面是后台返回的
    return @{@"uid" : @"id"};
}


@end
