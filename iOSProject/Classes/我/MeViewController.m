//
//  MeViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/28.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** list */
@property (nonatomic , strong) UITableView *tableview;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *rid = @"meTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.textLabel.text = DXWStringFormat(@"%ld",(long)indexPath.row);
    return cell;
}

#pragma mark - ljz

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

@end
