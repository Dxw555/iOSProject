//
//  BookViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/3/28.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "BookViewController.h"
#import "BookTableViewController.h"
@interface BookViewController ()
/** 列表控制器 */
@property (nonatomic , strong) BookTableViewController *bookTableController;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;  
    [self addChildViewController:self.bookTableController];
    [self.view addSubview:self.bookTableController.view];
    self.bookTableController.view.frame = CGRectMake(0, 0, DXWScreenWidth, DXWScreenHeight);
    DLog(@"self.bookTableController.view = %@",self.bookTableController.view);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - ljz
- (BookTableViewController *)bookTableController {
    if (!_bookTableController) {
        _bookTableController = [[BookTableViewController alloc] init];
    }
    return _bookTableController;
}

@end
