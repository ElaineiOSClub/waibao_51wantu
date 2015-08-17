//
//
/**
 * Copyright (c) www.bugull.com
 */
//
//


#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface Util : NSObject

//获得对象
+ (Util *)shareUtitObject;


//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

//去掉空格
+(NSString *) stringByRemoveTrim:(NSString *)str;

//NSString UTF8转码
+(NSString *)getUTF8Str:(NSString *)str;

+ (NSString *)getWebPercentEscapes:(NSString *)urlStr;

//根据文字 得到自适应的宽高
+ (CGSize)sizeForText:(NSString*)sText Font:(UIFont*)font forWidth:(CGFloat)fWidth;

//view根据原来的frame做调整，重新setFrame，fakeRect的4个参数如果<0，则用原来frame的相关参数，否则就用新值。
+ (void) View:(UIView *)view ReplaceFrameWithRect:(CGRect) fakeRect;

//view根据原来的bounds做调整，重新setBounds，fakeRect的4个参数如果<0，则用原来bounds的相关参数，否则就用新值。
+ (void) View:(UIView *)view ReplaceBoundsWithRect:(CGRect) fakeRect;

//根据@"#eef4f4"得到UIColor
+ (UIColor *) uiColorFromString:(NSString *) clrString;
+ (UIColor *) uiColorFromString:(NSString *) clrString alpha:(double)alpha;

//将原始图片draw到指定大小范围，从而得到并返回新图片。能缩小图片尺寸和大小
+ (UIImage*)ScaleImage:(UIImage*)image ToSize:(CGSize)newSize;
//将图片保存到document目录下
+ (void)saveDocImage:(UIImage *)tempImage WithName:(NSString *)imageName;

+ (int) defaultRandom;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg;
//获得window
+ (UIWindow *)getAppWindow;

//获取app版本
+ (NSString *)getAppVersion;
//获取app名字
+ (NSString *)getAppName;
//字符串转化data
+ (AppDelegate *)getAppDelegate;

// 十六进制转换为普通字符串
+ (NSString *)hexStringFromString:(NSString *)string;

// 普通字符串转为16进制
+ (NSString *)stringFromHexString:(NSString *)hexString;
#pragma mark-md5

+ (NSString *)getPassWordWithmd5:(NSString *)str;

//数组去重复对象
+ (NSMutableArray *)arraytoreToArray:(NSMutableArray *)aArray;

+ (NSMutableArray *)RemoveTheSameInArray:(NSMutableArray *)Array;

//获取图片路径
+ (NSString *)getFilePathWithImageName:(NSString *)imageName;

// 删除字符串中得空格
+ (NSString *)deleteTabsFromString:(NSString *)aStr;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end
