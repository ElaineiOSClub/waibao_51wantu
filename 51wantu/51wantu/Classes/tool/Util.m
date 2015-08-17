//
//
/**
 * Copyright (c) www.bugull.com
 */
//
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>
@interface Util ()

@end
static Util *class = nil;
@implementation Util

#pragma mark-utit
+ (Util *)shareUtitObject
{
    if (class == nil) {
        class = [[Util alloc] init];
    }
    return class;
}

//NSString UTF8转码
+(NSString *)getUTF8Str:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//不转webview打不开啊。。
+ (NSString *)getWebPercentEscapes:(NSString *)urlStr
{
    return [urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}


//去掉空格
+(NSString *) stringByRemoveTrim:(NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//根据文字、字体、文字区域宽度，得到文字区域高度
+ (CGSize)sizeForText:(NSString*)sText Font:(UIFont*)font forWidth:(CGFloat)fWidth{
//    CGSize szContent = [sText sizeWithFont:font constrainedToSize:CGSizeMake(fWidth, CGFLOAT_MAX)
//                             lineBreakMode:NSLineBreakByWordWrapping];
    CGSize szContent = [sText boundingRectWithSize:CGSizeMake(fWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return  szContent;
}

//根据文字信息和url，得到最终的文字message（总长度不超过140）。 url可以为nil。
-(NSString *)getMessageWithText:(NSString *)text url:(NSString *)url{
    if (text == nil && url == nil) {
        return nil;
    }
    if (text == nil) {
        return url;
    }
    
    //text != nil
    NSMutableString *messageText  = [[NSMutableString alloc] init];
    if (url == nil) {
        int trimlength =  (int)[text length]- 140;
        if (trimlength > 0) {
            [messageText appendFormat:@"%@",[text substringWithRange:NSMakeRange(0, [text length]-trimlength)]];
        }else{
            [messageText appendFormat:@"%@",text];
        }
//        NSLog(@"%u%@",[messageText length],messageText);
        return messageText;
    }else{
        int trimlength =  (int)[text length] + (int)[url length] - 140;
        if (trimlength > 0) {
            [messageText appendFormat:@"%@%@",[text substringWithRange:NSMakeRange(0, [text length]-trimlength)],url];
        }else{
            [messageText appendFormat:@"%@%@",text,url];
        }
//        NSLog(@"%u%@",[messageText length],messageText);
        return messageText;
    }
    
}

//view根据原来的frame做调整，重新setFrame，fakeRect的4个参数如果<0，则用原来frame的相关参数，否则就用新值。
+ (void) View:(UIView *)view ReplaceFrameWithRect:(CGRect) fakeRect{
    CGRect frame = view.frame;
    CGRect newRect;
    newRect.origin.x = fakeRect.origin.x > 0 ? fakeRect.origin.x : frame.origin.x;
    newRect.origin.y = fakeRect.origin.y > 0 ? fakeRect.origin.y : frame.origin.y;
    newRect.size.width = fakeRect.size.width > 0 ? fakeRect.size.width : frame.size.width;
    newRect.size.height = fakeRect.size.height > 0 ? fakeRect.size.height : frame.size.height;
    [view setFrame:newRect];
}

//view根据原来的bounds做调整，重新setBounds，fakeRect的4个参数如果<0，则用原来bounds的相关参数，否则就用新值。
+ (void) View:(UIView *)view ReplaceBoundsWithRect:(CGRect) fakeRect{
    CGRect bounds = view.bounds;
    CGRect newRect;
    newRect.origin.x = fakeRect.origin.x > 0 ? fakeRect.origin.x : bounds.origin.x;
    newRect.origin.y = fakeRect.origin.y > 0 ? fakeRect.origin.y : bounds.origin.y;
    newRect.size.width = fakeRect.size.width > 0 ? fakeRect.size.width : bounds.size.width;
    newRect.size.height = fakeRect.size.height > 0 ? fakeRect.size.height : bounds.size.height;
    [view setBounds:newRect];
}



//根据@"#eef4f4"得到UIColor
+ (UIColor *) uiColorFromString:(NSString *) clrString
{
	return [Util uiColorFromString:clrString alpha:1.0];
}

//将原始图片draw到指定大小范围，从而得到并返回新图片。能缩小图片尺寸和大小
+ (UIImage*)ScaleImage:(UIImage*)image ToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//将图片保存到document目录下
+ (void)saveDocImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.4);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

+ (UIColor *) uiColorFromString:(NSString *) clrString alpha:(double)alpha
{
	if ([clrString length] == 0) {
		return [UIColor clearColor];
	}
	
	if ( [clrString caseInsensitiveCompare:@"clear"] == NSOrderedSame) {
		return [UIColor clearColor];
	}
	
	if([clrString characterAtIndex:0] == 0x0023 && [clrString length]<8)
	{
		const char * strBuf= [clrString UTF8String];
		
		int iColor = (int)(strtol((strBuf+1), NULL, 16));
		typedef struct colorByte
		{
			unsigned char b;
			unsigned char g;
			unsigned char r;
		}CLRBYTE;
		CLRBYTE * pclr = (CLRBYTE *)&iColor;
		return [UIColor colorWithRed:((double)pclr->r/255) green:((double)pclr->g/255) blue:((double)pclr->b/255) alpha:alpha];
	}
	return [UIColor blackColor];
}

//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//将浮点数转换为NSString，并设置保留小数点位数
//+ (NSString *)getStringFromFloat:(float) f withDecimal:(int) decimalPoint{
//    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setNumberStyle:kCFNumberFormatterDecimalStyle];
//    [numberFormatter setMaximumFractionDigits:decimalPoint];
//
//    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:f]];
//}

+ (int) randomFromMin:(int)min ToMax:(int)max
{
    int randNum = arc4random() % (max-min) + min; //create the random number.
    return randNum;
}

+ (int) defaultRandom
{
    return [self randomFromMin:1 ToMax:9999];
}

+ (UIWindow *)getAppWindow
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}


+ (NSString *)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)getAppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"]; // CFBundleDisplayName
}


//警告框
+ (UIAlertView *)showAlertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    return alert;
}
//delegate对象
+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//获得本地device字典
+ (NSMutableDictionary *)getlocalDeviceDictary
{
    NSMutableDictionary *deviceDictary = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceDictary"];
    
    return deviceDictary;
    
}

////冒泡排序
//
//+ (NSMutableArray *)sortGroupArray:(NSMutableArray *)GroupArray
//{
//    
//    for (int i = 0; i<[GroupArray count]; i++)
//    {
//        for (int j=i+1; j<[GroupArray count]; j++)
//        {
//            
//            GroupEntity *groupi = GroupArray[i];
//            GroupEntity *groupj = GroupArray[j];
//            
//            int a = [groupi.number intValue];
//            int b = [groupj.number intValue];
//            if (a > b)
//            {
//                [GroupArray replaceObjectAtIndex:i withObject:groupj];
//                [GroupArray replaceObjectAtIndex:j withObject:groupi];
//            }
//        }
//    }
//    return GroupArray;
//}
#pragma mark-md5
+ (NSString *)getPassWordWithmd5:(NSString *)str
{
    if (str == nil || [str isEqualToString:@""]) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    NSString * string = [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15]
                         ];
    return [string uppercaseStringWithLocale:[NSLocale currentLocale]];
}

//获取图片路径
+ (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    return [docDir stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
}


//数组去重复对象
+ (NSMutableArray *)arraytoreToArray:(NSMutableArray *)aArray
{
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i<aArray.count; i++)
    {
        id str = [aArray objectAtIndex:i];
        
        if ([array containsObject:str])
        {
            
        }
        else
        {
            [array addObject:str];
        }
    }
    
    return array;
}

+ (NSMutableArray *)RemoveTheSameInArray:(NSMutableArray *)Array{
NSMutableArray *categoryArray = [NSMutableArray array];
for (unsigned i = 0; i < [Array count]; i++) {
    if ([categoryArray containsObject:Array[i]]== NO) {
        [categoryArray addObject:Array[i]];
        }
    
    }
     return categoryArray;
}

// 十六进制转换为普通字符串
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

+ (NSString *)deleteTabsFromString:(NSString *)aStr
{
    NSMutableString *tempStr = [NSMutableString string];
    // 去空格
    NSArray *arr = [aStr componentsSeparatedByString:@" "];
    for (int i = 0; i < arr.count; i++) {
        [tempStr appendString:arr[i]];
    }
    NSString *str = [NSString stringWithFormat:@"%@",tempStr];
    // 去 < >
    str = [str substringWithRange:NSMakeRange(1, tempStr.length - 2)];
    return str;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
