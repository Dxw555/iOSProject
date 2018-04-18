//
//  FindViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/28.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()<UITableViewDataSource, UITableViewDelegate>
/** tableview */
@property (nonatomic , strong) UITableView *tableview ;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    DLog(@"self.tableview = %@",self.tableview);
    
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *rid = @"find";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.textLabel.text = DXWStringFormat(@"%ld",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }else{
        self.tabBarController.tabBar.hidden = YES;
    }
}

#pragma mark - ljz

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - DXWStatusHeight - 44) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableview;
}
@end
