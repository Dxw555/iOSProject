//
//  EPUBViewController.h
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPUBModel.h"

@interface EPUBViewController : UIViewController

@property (nonatomic, copy) void(^showFinish)();

/** epubModel */
@property (nonatomic , strong) EPUBModel *epub;

@property (nonatomic, assign) NSInteger currentPageRefIndex;        //当前页码索引
@property (nonatomic, assign) NSInteger currentOffYIndexInPage;     //页码内 滚动索引
@property (nonatomic, assign) BOOL isPrePage; //翻上一页

@end
