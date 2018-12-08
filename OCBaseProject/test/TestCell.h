//
//  TestCell.h
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCell : UITableViewCell

@property (nonatomic, strong) UILabel       *detailLabel;

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
