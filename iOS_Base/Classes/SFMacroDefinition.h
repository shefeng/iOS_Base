//
//  SFMacroDefinition.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#ifndef SFMacroDefinition_h
#define SFMacroDefinition_h

#define ACC [SFAppCommonConstant sharedCommonConstant]

#define WEAK_SELF @weakify(self);
#define STRONG_SELF @strongify(self); if(!self){return;};

/* block块 */
#define BLOCK_EXEC(block,...) if(block){block(__VA_ARGS__);};

/* GCD */
#define DISPATCH_ASYNC_DEFAULT(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),block)
#define DISPATCH_ASYNC_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

/* 版本号 */
#define kVersion_Coding [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_Coding [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"]

/* 日志 */
#define DebugLog(s,...) NSLog(@"%s(%d): %@",__FUNCTION__,__LINE__,[NSString stringWithFormat:(s), ## __VA_ARGS__])

/* NSUserDefaults 实例化 */
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/* 安全的字符串 */
#define SafeStr(str) (isEmptyStr(str) ? @"" : str)

/* 对象为空或空字符串 */
#define isEmptyStr(str) (str == nil || [str isEqualToString:@""])
#define isEmptyObj(obj) (obj == nil || ([obj isKindOfClass:[NSNull class]]) || (([obj respondsToSelector:@selector(length)]) && ([obj length] == 0)) || (([obj respondsToSelector:@selector(count)]) && ([obj count] == 0)))

/* 屏幕宽高 */
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

/* 状态栏高度 */
#define kStatus_Height [[UIApplication sharedApplication]statusBarFrame].size.height

/* 导航栏高度 */
#define kNav_Height self.navigationController.navigationBar.frame.size.height

/* 状态栏和导航栏高度 */
#define kStatusNav_Height (kStatus_Height + kNav_Height)

/* 工具栏高度 */
#define kTabBar_Height self.tabBarController.tabBar.frame.size.height

/* 缩放比例 */
#define kAdaptWidth(_X_) (_X_*(kScreen_Width/375.f))

/* RGB颜色 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBA_HEX(colorRgb,alp) [UIColor colorWithRed:((colorRgb&0xFF0000)>>16)/255.0 green:((colorRgb&0xFF00)>>8)/255.0 blue:((colorRgb&0xFF)/255.0) alpha:alp]
#define RGB_HEX(colorRgb) RGBA_HEX(colorRgb,1.0)

/* 常用颜色 */
#define kColorWhite [UIColor whiteColor]
#define kColorRed [UIColor redColor]
#define kColorBlack [UIColor blackColor]
#define kColorBlue [UIColor blueColor]
#define kColorClear [UIColor clearColor]

#define kColor333 RGB_HEX(0x333333)
#define kColor666 RGB_HEX(0x666666)
#define kColor999 RGB_HEX(0x999999)

/* 字体 */
#define kFont_PF_Regular(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize * kScreen_Width/375.f]
#define kFont_PF_Medium(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize * kScreen_Width/375.f]
#define kFont_PF_Light(fontSize) [UIFont fontWithName:@"PingFangSC-Light" size:fontSize * kScreen_Width/375.f]
#define kFont_PF_Semibold(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize * kScreen_Width/375.f]

#define kFont_Sys(fontSize) [UIFont systemFontOfSize:fontSize * kScreen_Width/375.f]
#define kFont_Sys_Bold(fontSize) [UIFont boldSystemFontOfSize:fontSize * kScreen_Width/375.f]
#define kFont_Sys_Light(fontSize) [UIFont systemFontOfSize:fontSize * kScreen_Width/375.f]
#define kFont_Sys_Weight(fontSize, weightType)  [UIFont systemFontOfSize:fontSize * kScreen_Width/375.f weight:weightType]

/* 图片 */
#define kImage_file(imageName) [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:@"png"]]
#define kImage_Name(imageName) [UIImage imageNamed:imageName]

#define SafeAreaBottom kWindow.safeAreaInsets.bottom

#define SafeAreaTop kWindow.safeAreaInsets.top

#endif /* SFMacroDefinition_h */
