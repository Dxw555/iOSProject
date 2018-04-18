//
//  BookTableViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/8.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "BookTableViewController.h"
#import "BookTableViewCell.h"

#import "EPUBReadViewController.h"
@interface BookTableViewController ()

@end

@implementation BookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *rid = @"bookCell";
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    if(!cell){
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EPUBReadViewController *vc = [[EPUBReadViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
