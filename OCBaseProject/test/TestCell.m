//
//  TestCell.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) wSelf = self;
        self.detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailLabel];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.right.equalTo(wSelf.contentView).offset(-10);
            make.top.equalTo(wSelf.contentView).offset(10);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithText:(NSString *)text {
    self.detailLabel.text = text;
}


@end
