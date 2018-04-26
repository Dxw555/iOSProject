//
//  EPUBReadSetting.h
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPUBReadSetting : NSObject

@property (nonatomic, assign) NSInteger displayStyle;               //当前显示样式改变
@property (nonatomic, assign) NSInteger currentTextSize;            //文字大小
@property (nonatomic, strong) NSMutableDictionary *dictPageWithOffYCount;    //记录 ［页码，滚动次数］
@property (nonatomic, assign) NSInteger currentPageRefIndex;        //当前页码索引
@property (nonatomic, assign) NSInteger currentOffYIndexInPage;     //页码内 滚动索引
@property (nonatomic, strong) NSMutableArray *arrTheme;     //主题数据
@property (nonatomic, assign) NSInteger themeIndex;         //当前主题索引
@property (nonatomic, strong) UIView *maskLightView;        //亮度遮罩层
@property (nonatomic, assign) double maskValue;             //范围[0 - 1.0]
@property (nonatomic, strong) NSMutableArray *arrFont;      //字体
@property (nonatomic, assign) NSInteger fontSelectIndex;    //当前字体索引


@end
