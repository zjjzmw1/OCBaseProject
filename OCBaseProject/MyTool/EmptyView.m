//
//  EmptyView.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        __weak typeof(self) wSelf = self;
        //默认图。
        _imageV = [[UIImageView alloc]init];
        [self addSubview:_imageV];
        _imageV.frame = CGRectMake(0, 0, 110, 110);
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 110));
            make.centerX.mas_equalTo(wSelf.mas_centerX).with.offset(0);
            make.centerY.mas_equalTo(wSelf.mas_top).with.offset(-20);
        }];
        _imageV.backgroundColor = [UIColor clearColor];
        _imageV.image = [UIImage imageNamed:@"all_default_no_data_img"];
        //默认文字。
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        _label.backgroundColor = [UIColor clearColor];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.mas_left).with.offset(80);
            make.right.equalTo(wSelf.mas_right).with.offset(-80);
            make.top.equalTo(wSelf.imageV.mas_bottom).with.offset(50);
        }];
        _label.numberOfLines = 0;
        _label.font = FONT_Helvetica(12);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor getContentColor];
        self.backgroundColor = [UIColor getBackgroundColor];
        
    }
    
    return self;
}

#pragma mark - 常用的方法
- (void)image:(UIImage *)image labelString:(NSString *)labelString {
    if (image) {
        self.imageV.image = image;
        [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
        }];
    } else {
        self.imageV.image = nil;
        __weak typeof(self) wSelf = self;
        [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
            make.centerX.mas_equalTo(wSelf.mas_centerX).with.offset(0);
            make.centerY.mas_equalTo(wSelf.mas_top).with.offset(20);
        }];
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.mas_left).with.offset(80);
            make.right.equalTo(wSelf.mas_right).with.offset(-80);
            make.top.equalTo(wSelf.imageV.mas_bottom).with.offset(20);
        }];
    }
    self.label.text = labelString;
    self.label.textColor = [UIColor getContentSecondColor];
    if (![NSString isEmptyString:labelString]) {
        [self.superview bringSubviewToFront:self];
        [self setHidden:NO];
    }
}


@end
