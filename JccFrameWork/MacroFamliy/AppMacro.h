//
//  AppMacro.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-22.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#ifndef WSLibrary_AppMacro_h
#define WSLibrary_AppMacro_h


#pragma mark 
#ifdef DEBUG

#pragma mark ----------打印字符串----------
#define DLOG(...)      NSLog(__VA_ARGS__)

#pragma mark ----------打印点----------
#define DLOGPOINT(p)   NSLog(@"%f,%f", p.x, p.y);

#pragma mark ----------打印尺寸----------
#define DLOGSIZE(size) NSLog(@"%f,%f", size.width, size.height);

#pragma mark ----------打印位置----------
#define DLOGFRAME(p)   NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

#pragma mark ----------打印方法名----------
#define DLOGFUNC       NSLog(@"[%d]<--%s",__LINE__,__FUNCTION__);
#else

#define DLOG(...)
#define DLOGPOINT(p)
#define DLOGSIZE(p)
#define DLOGFRAME(p)
#define DLOGFUNC

#endif






#pragma mark 
#pragma mark ----------Appdelegate----------
#ifndef APPLICATIONDELEGATE

#define APPLICATIONDELEGATE   ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#endif




#pragma mark 
#pragma mark ----------生成字符串----------
#define str(...) [NSString stringWithFormat:__VA_ARGS__]

#pragma mark ----------选择图片名称----------
#define img(name) [UIImage imageNamed:name]



#pragma mark 
#pragma mark ----------弱引用对象----------
#define WEAKSELF typeof(self) __weak weakSelf = self;

#pragma mark ----------强引用对象----------
#define STRONGSELF typeof(self) __strong strongSelf = self;





#pragma mark 
#pragma mark ----------对象是否为空----------
static inline BOOL IsObjectEmpty(id thing){
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}
#pragma mark ----------字符串是否为空----------
static inline BOOL IsStringEmpty(NSString *string){
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark --------------------------------------------
#pragma mark Block安全引用
#define Unsafe_self __unsafe_unretained typeof(self) vc = self;


#pragma mark 
#pragma mark ----------是否为iPhone5----------
#ifndef iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

#pragma mark ----------是否为iPhone4----------
#ifndef iPhone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif


//NavBar高度
#define NavigationBar_HEIGHT 44


#pragma mark 
#pragma mark ----------设备屏幕高度----------
#ifndef UIScreenHeight
#define UIScreenHeight   [UIScreen mainScreen].bounds.size.height
#endif

#pragma mark ----------设备屏幕宽度----------
#ifndef UIScreenWidth
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#endif



#pragma mark 
#pragma mark ----------是否大于ios7----------
#ifndef IOS7
#define IOS7            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?YES:NO)
#endif

#pragma mark ----------ios7补丁----------
#ifndef IOS7_PADDING
#define IOS7_PADDING    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?20:0)
#endif



#pragma mark 
#pragma mark ----------安全释放----------
#ifndef RELEASE
#define RELEASE(x)         if(nil != (x)){ [(x) release]; (x) = nil;}
#endif

#define MY_BackGoundColor [UIColor colorWithHex:@"099FDE"]


//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//----------------------系统----------------------------


//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil



//----------------------内存----------------------------


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象(文件)
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------



//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//----------------------颜色类--------------------------



//----------------------其他----------------------------

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]


//定义一个API
#define APIURL                @"http://xxxxx/"
//登陆API
#define APILogin              [APIURL stringByAppendingString:@"Login"]

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)



//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}



#endif

