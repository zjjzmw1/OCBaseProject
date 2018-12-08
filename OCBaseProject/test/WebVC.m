//
//  WebVC.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/23.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect bouds = [UIScreen mainScreen].bounds;
    UIWebView* webView = [[UIWebView alloc]initWithFrame:bouds];
    NSURL* url = [NSURL URLWithString:self.urlStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
