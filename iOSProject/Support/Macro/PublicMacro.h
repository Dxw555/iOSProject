//
//  PublicMacro.h
//  iOSBase
//
//  Created by 360doc on 2017/7/25.
//  Copyright © 2017年 邓晓文. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

#pragma mark - DEBUG模式下打印日志
#ifdef DEBUG

#define DLog(fmt,...) NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);

#else

#define DLog(...)

#endif


#pragma mark - 判断是真机or模拟器［注：记得先判断是否为模拟器咯，否则会失败的哦］

#if TARGET_IPHONE_SIMULATOR//模拟器

#define DXWSimulator YES

#elif TARGET_OS_IPHONE//真机

#define DXWSimulator NO

#endif

#pragma mark - 打印当前方法名
//打印当前方法名
#define DXWCurrentMethod() ITTDPRINT(@"%s",__PRETTY_FUNCTION__)

#pragma mark - 获取系统对象

#define DXWApplication [UIApplication sharedApplication]

#define DXWAppDelegate [UIApplication sharedApplication].delegate

#define DXWAppWindow [UIApplication sharedApplication].delegate.window

#define DXWRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define DXWUserDefaults [NSUserDefaults standardUserDefaults]

#define DXWNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - Pad或Phone
//是否是iPad
#define DXWiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)
//是否是iPhone
#define DXWiPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? YES : NO)

#pragma mark - 沙盒路径
//沙盒Temp路径
#define DXWPathTemp NSTemporaryDirectory()
//沙盒Document路径
#define DXWPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//沙盒Cache路径
#define DXWPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]]

#pragma mark - 当前系统版本
//当前系统版本
#define DXWSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

#pragma mark - app版本
//app版本
#define DXWAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark - 当前语言
//当前语言
#define DXWLanguage ([NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - 强弱引用
//弱引用
#define DXWWeakSelf(type) __weak typeof(type)weak##type = type;
//强引用
#define DXWStrongSelf(type) __strong typeof(type)type = weak##type;

#pragma mark - GCD
//gcd 全局队列 异步
#define DXW_GCD_ASYNC_BLOCK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block)
//gcd 返回主线程
#define DXW_GCD_MAIN_BLOCK(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark - 获取屏幕宽高
//屏幕大小
#define DXWScreenBounds [UIScreen mainScreen].bounds
//屏幕宽
#define DXWScreenWidth ([[UIScreen mainScreen]bounds].size.width)
//屏幕高
#define DXWScreenHeight [[UIScreen mainScreen]bounds].size.height

#pragma mark - 屏幕尺寸大小
//是否是iPhone4大小的屏幕
#define DXWiPhone4Size (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
//是否是iPhone5大小的屏幕
#define DXWiPhone5Size (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
//是否是iPhone6大小的屏幕
#define DXWiPhone6Size (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
//是否是iPhone6P大小的屏幕
#define DXWiPhone6PSize (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))
//是否是iPhoneX大小的屏幕
#define DXWiPhoneXPSize (CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size))

#pragma mark - 高
//系统状态栏高度
#define DXWStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//iphonex底部增加的高度
#define DXWBottomHeight (DXWiPhoneXPSize ? 34 : 0)

#pragma mark - 颜色
//透明色
#define DXWColorClear [UIColor clearColor]
//白色
#define DXWColorWhite [UIColor whiteColor]
//黑色
#define DXWColorBlack [UIColor blackColor]
//灰色
#define DXWColorGray [UIColor grayColor]
//红色
#define DXWColorRed [UIColor redColor]

#pragma mark - 自定义颜色

#define DXWColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define DXWColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define DXWColorHexadecimal(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DXWColorHexadecimalAndAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#pragma mark - 字体

#define DXWFont(fontSize) [UIFont systemFontOfSize:fontSize]

#define DXWBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#pragma mark - 拼接字符串

#define DXWStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#pragma mark - 数据验证
//是否是非空字符串
#define DXWValidStr(f) (f!=nil && [f isKindOfClass:[NSString class]] && f)
//是否是非空字典
#define DXWValidDict(f) (f != nil && [f isKindOfClass:[NSDictionary class]] && f.count)
//是否是非空数组
#define DXWValidArray(f) (f != nil && [f isKindOfClass:[NSArray class]] && f.count)
//是否是NSNumber类型
#define DXWValidNum(f) (f != nil && [f isKindOfClass:[NSNumber class]])
//是否是cls类型
#define DXWValidClass(f,cls) (f != nil && [f isKindOfClass:[cls class]])
//是否是NSData类型
#define DXWValidData(f) (f != nil && [f isKindOfClass:[NSData class]])
//获取安全字符串
#define DXWSafeStr(f) (DXWValidStr(f) ? f : @"")
//判断字符串str中是否含有字符串key
#define DXWHasString(str,key) ([str rangeOfString:key].location != NSNotFound)

#pragma mark - 弧度角度转换

#define DXWDegreesToRadian(x) (M_PI * (x) / 180.0)

#define DXWRadianToDegrees(radian) ((radian*180.0)/(M_PI))

#pragma mark - view的frame
//获取view的frame（不建议使用）
#define DXWViewWidth(view)  (view.frame.size.width)

#define DXWViewHeight(view) (view.frame.size.height)

#define DXWViewX(view)      (view.frame.origin.x)

#define DXWViewY(view)      (view.frame.origin.y)


#endif /* PublicMacro_h */
