//
//  TestListVC.m
//  MyOC
//
//  Created by zhangmingwei on 2018/11/21.
//  Copyright © 2018 dandan. All rights reserved.
//

#import "TestListVC.h"

#import "TestCell.h"

@interface TestListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableV;
@property (nonatomic, strong) NSMutableArray    *arr;

@end

@implementation TestListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAllV];
    
}

- (void)initAllV {
    self.tableV = [UITableView getTableView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    [self.tableV registerClass:[TestCell class] forCellReuseIdentifier:@"TestCell"];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    
    if (self.arr.count > indexPath.row) {
        [cell updateCellWithText:self.arr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
