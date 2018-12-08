//
//  NSString+IOSUtils.m
//  Toos
//
//  Created by xiaoming on 15/1/30.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "NSString+IOSUtils.h"
#import <CommonCrypto/CommonDigest.h>
// 解析域名用的
#include <netdb.h>
#include <arpa/inet.h>

@implementation NSString (IOSUtils)

#pragma mark - 截取两个特殊字符串中间的字符串。

- (NSString *)rangeWithStartString:(NSString *)startString withEndString:(NSString *)endString
{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    if (startRange.length== 0 || endRange.length == 0)
    {
        return @"";
    }
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [self substringWithRange:range];
    
    return result;
}

#pragma mark - 判断字符串是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

#pragma mark - 去除两端空格
+(NSString *)removeTrimmingBlank:(NSString *)string{
    ///去除两端空格
    ///sender 是输入框里面的text。
    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return temp;
    
}

#pragma mark - 去除所有空格
+(NSString *)removeAllBlank:(NSString *)string{
    ///去所有的空格。
    ///string 是输入框里面的text。
    NSString *resultString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultString;
}

- (NSString*)md5String{
    if (self == nil || [self length] == 0){
        return @"";
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

- (id)jsonvalue{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    if (!data){
        NSLog(@"解析json字符串出错！");
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error){
        NSLog(@"解析json字符串出错！");
    }
    return result;
}

- (BOOL)stringContainsSubString:(NSString *)subString {
    NSRange aRange = [self rangeOfString:subString];
    if (aRange.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

- (BOOL)matchStringWithRegextes:(NSString*)regString{
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regString];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *  @brief
 *
 *  @param string 要转化成 16 进制 data 的 16 进制字符串
 *
 *  @return 16进制 data
 */
- (NSData*)hexData{

    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx + 2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString*)digitString:(NSInteger)digit{
    NSString* string = [self copy];
    while (string.length < digit) {
         string = [@"0" stringByAppendingString:string];
    }
    return string;
}

/*!
 @author 王金宇, 16-05-09 16:05:21
 
 @brief 判断一个字符串是否为空字符串
 
 @param string 要判断的字符串
 
 @return 判断结果
 
 @since 3.0
 */
+ (BOOL)isEmptyString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    
    if ([string isKindOfClass:[[NSNull null] class]]) {
        return YES;
    }
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    return NO;
}

#pragma mark ====去掉float类型数据后面的 无效的 0 ==========必须是有两个小数的时候才能用。=======.2f=======
+(NSString *)clipZero:(NSString *)string{
    if (!string) {
        return nil;
    }
    if ([string rangeOfString:@"."].location == NSNotFound) {
        return string;
    }
    
    for (int i = 0; i < 2; ++i) {
        if ([string hasSuffix:@"0"]) {
            string = [string substringToIndex:string.length - 1];
        }
    }
    if ([string hasSuffix:@"."]) {
        string = [string substringToIndex:string.length - 1];
    }
    return string;
}

#pragma mark - 获取当前时间的时间戳。
+ (NSString *)getCurrentTimeString {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}


- (BOOL)isValidEmail {
    NSString *emailPattern =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    return match != nil;
}

#pragma mark - trim string
- (NSString *)trim {
    
    return [[NSString stringWithFormat:@"%@",self] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


/**
 获取字符串的size

 @param font 字体
 @return
 */
- (CGSize)getSizeWithFont:(UIFont *)font {
    CGSize fontSize = [self sizeWithAttributes:@{NSFontAttributeName : font}];
    return fontSize;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

/**
 *  textFild 限制字数的方法  在这里用 self.textField rac_signalForControlEvents:UIControlEventEditingChanged
 *
 *  @param maxTextLength 最大长度
 *  @param resultString  返回的textField.text 的值
 *  @param textField     textField 对象
 *
 *  @return 输入后的结果字符串
 */
+ (NSString *)textFieldLimtWithMaxLength:(int)maxTextLength resultString:(NSString *)resultString textField:(UITextField *)textField {
    NSString *toBeString = textField.text;
    
    resultString = textField.text;//业务逻辑
    NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //业务逻辑
            if (toBeString.length > maxTextLength) {
                textField.text = [toBeString substringToIndex:maxTextLength];
                resultString = [textField.text substringToIndex:maxTextLength];
            } else {
                resultString = textField.text;
            }
        }
        
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        //业务逻辑
        if (toBeString.length > maxTextLength) {
            textField.text = [toBeString substringToIndex:maxTextLength];
            resultString = [textField.text substringToIndex:maxTextLength];
        } else {
            resultString = textField.text;
        }
    }
    
    return resultString;
}

/**
 *  textView 限制字数的方法  在这里用 self.textView rac_textSignal
 *
 *  @param maxTextLength 最大长度
 *  @param resultString  返回的textView.text 的值 可以传空
 *  @param textView     textView 对象
 *
 *  @return 输入后的结果字符串
 */
+ (NSString *)textViewLimtWithMaxLength:(int)maxTextLength resultString:(NSString *)resultString textView:(UITextView *)textView {
    NSString *toBeString = textView.text;
    
    resultString = textView.text;//业务逻辑
    //    NSString *lang = textView.textInputMode.primaryLanguage; // 键盘输入模式
    
    //    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
    //        UITextRange *selectedRange = [textView markedTextRange];
    //        //获取高亮部分
    //        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    //
    //        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //        if (!position) {
    //            //业务逻辑
    //            if (toBeString.length > maxTextLength) {
    //                textView.text = [toBeString substringToIndex:maxTextLength];
    //                resultString = [textView.text substringToIndex:maxTextLength];
    //            } else {
    //                resultString = textView.text;
    //            }
    //        } else {
    ////            if (toBeString.length > maxTextLength) {
    ////                textView.text = [toBeString substringToIndex:maxTextLength];
    ////                resultString = [textView.text substringToIndex:maxTextLength];
    ////            } else {
    ////                resultString = textView.text;
    ////            }
    //        }
    //
    //        // 有高亮选择的字符串，则暂不对文字进行统计和限制
    //    }
    //    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    //    else {
    //业务逻辑
    if (toBeString.length > maxTextLength) {
        textView.text = [toBeString substringToIndex:maxTextLength];
        resultString = [textView.text substringToIndex:maxTextLength];
    } else {
        resultString = textView.text;
    }
    //    }
    
    return resultString;
}

+ (NSString *)quKongGe:(NSString *)sender {
    ///去除两端空格
    ///sender 是输入框里面的text。
    NSString *temp = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return temp;
}

+ (NSString *)quKongGeAndEnder:(NSString *)sender {
    /// 去除两端空格和回车
    NSString *text = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    return text;
}

/*
 邮箱隐藏规则，
 1. 字符>5 位就隐藏@符中间的4位字符 例如：zhaoweiyu@speedx.com 隐藏后 zha****yu@speedx.com
 2. 字符=5位隐藏@后前4位     例如：weiyu@speedx.com 隐藏后 w****@speedx.com
 3. 字符<=4位就隐藏@符号前的全部字符 例如：eiyu@speedx.com  隐藏后 ****@speedx.com
 */
#pragma mark - 手机、邮箱添加 * 显示
+ (NSString *)getStarString:(NSString *)oldString {
    NSString *newString = nil;
    if ([NSString isEmptyString:oldString]) {
        return @"";
    }
    if ([oldString containsString:@"@"]) { // 邮箱
        NSString *leftString = [oldString componentsSeparatedByString:@"@"][0];
        if (leftString.length > 4) { // @符号前长度大于4个字符
            if (leftString.length == 5) {
                newString = [NSString stringWithFormat:@"%@****%@",[leftString substringToIndex:leftString.length - 4],[oldString substringFromIndex:[oldString rangeOfString:@"@"].location]];
            } else { // 大于5的情况
                newString = [NSString stringWithFormat:@"%@****%@",[leftString substringToIndex:(leftString.length - 3)/2],[oldString substringFromIndex:(leftString.length - 3)/2 + 4]];
            }
        } else { // @符号前长度小于4个字符
            NSString *star = @"*";
            if (leftString.length == 2) {
                star = @"**";
            } else if (leftString.length == 3) {
                star = @"***";
            } else if (leftString.length == 4) {
                star = @"****";
            }
            newString = [NSString stringWithFormat:@"%@%@",star,[oldString substringFromIndex:[oldString rangeOfString:@"@"].location]];
        }
    } else { // 手机号
        if (oldString.length > 7) {
            newString = [NSString stringWithFormat:@"%@****%@",[oldString substringToIndex:oldString.length - 8],[oldString substringFromIndex:oldString.length - 4]];
        } else {
            newString = oldString;
        }
    }
    return newString;
}

///根据域名获取ip地址 - 可以用于控制APP的开关某一个入口，比接口方式速度快的多
+ (NSString*)getIPWithHostName:(const NSString*)hostName {
    const char *hostN= [hostName UTF8String];
    struct hostent* phot;
    @try {
        phot = gethostbyname(hostN);
    } @catch (NSException *exception) {
        return nil;
    }
    struct in_addr ip_addr;
    if (phot == NULL) {
        NSLog(@"获取失败");
        return nil;
    }
    memcpy(&ip_addr, phot->h_addr_list[0], 4);
    char ip[20] = {0}; inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
    NSLog(@"ip=====%@",strIPAddress);
    return strIPAddress;
}

/// 获取电话号码
+ (NSString *)getPhoneNumber:(NSString *)phoneNumber {
    NSString *lastStr = @"";
    if ([NSString isEmptyString:phoneNumber]) {
        return lastStr;
    } else {
        lastStr = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
        lastStr = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return  lastStr;
}

/**
 返回需要的视频图片

 @param videoUrlStr 网络的视频图片
 @return
 */
+ (NSString *)getVideoUrlString:(NSString *)videoUrlStr {
    if ([videoUrlStr containsString:@"/offset/1/w/"]) {
//        NSString *lastStr = [videoUrlStr substringToIndex:[videoUrlStr rangeOfString:@"/offset/1/w/"].location + 9];
//        return lastStr;
        NSString *lastStr = [videoUrlStr stringByReplacingOccurrencesOfString:@"/offset/1/w/" withString:@"/offset/0/w/"];
        return lastStr;
    } else {
        return videoUrlStr;
    }
}
@end
