//
//  NSString+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


#pragma mark --------------------------------------------
-(NSString *)replaceArrStr:(NSArray *)proArr with:(NSString *)keyStr
{
    NSString *str = self;
    for (NSInteger i = 0; i < [proArr count]; i++) {
        str = [str stringByReplacingOccurrencesOfString:[proArr objectAtIndex:i] withString:keyStr];
    }
    return str;
}

#pragma mark ----------ExistDetecting----------
- (BOOL)isExist{
    NSString *string = [self copy];
    if (!string || string.length == 0) {
        return NO;
    }else{
        return YES;
    }
    
}



#pragma mark ----------StringDeleteSpace&Wrap----------
- (NSString *)deleteWhitespaceAndWrapOnBothEnds{
    
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",self];
    
    return [NSString stringWithFormat:@"%@",[mutableString stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}
- (NSString *)deleteAllWhitespaceAndWrap{
    
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@",self];
     return [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}



- (BOOL)hasSubstring:(NSString *)subString{
    NSRange range = [self rangeOfString:subString];
    if (range.location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark ----------StringValidate----------
+ (BOOL) validateMobilePhone:(NSString *)mobilePhone{
    NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[012356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:mobilePhone];
}
+ (BOOL) validateMobilePhoneTextFiled:(UITextField *)textFiled{
    
    if (textFiled.text.length == 0 || [[textFiled.text deleteWhitespaceAndWrapOnBothEnds] length] == 0) {
        return NO;
    }
    
    return [self validateMobilePhone:[textFiled.text deleteWhitespaceAndWrapOnBothEnds]];
}
+ (BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
+ (BOOL) validateEmailTextFiled:(UITextField *)textFiled{
    
    if (textFiled.text.length == 0 || [[textFiled.text deleteWhitespaceAndWrapOnBothEnds] length] == 0) {
        return NO;
    }
    
    return [self validateEmail:[textFiled.text deleteWhitespaceAndWrapOnBothEnds]];
}
+ (BOOL) validateNumber:(NSString *)number{
    
    NSString *regex = @"[0-9]*";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [numberTest evaluateWithObject:number];
}
+ (BOOL) validateStrictNumber:(NSString *)number{
    
    //严格判断
    NSString *regex = @"^((\\(\\d{2,3}\\))|(\\d{4}\\-))?1[3,4,5,8]\\d{9}$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [numberTest evaluateWithObject:number];
    
}
+ (BOOL) validateTelephone:(NSString *)telephone{
    //判断电话
    NSString *regex = @"^[\\d+-]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numberTest evaluateWithObject:telephone];
}
+ (BOOL) validateIDCardNumber:(NSString *)value {
    
    if (value.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[value substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[value substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[value substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
    
    //==============================================================================================
    //去除空格
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22",
                           @"23", @"31", @"32", @"33", @"34", @"35", @"36",
                           @"37", @"41", @"42", @"43", @"44", @"45", @"46",
                           @"50", @"51", @"52", @"53", @"54", @"61", @"62",
                           @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}
+ (BOOL) validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
+ (BOOL) validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
+ (BOOL) validatefloatString:(NSString *)floatString{
    
    if ([floatString hasPrefix:@"."] || [floatString hasSuffix:@"."]) {
        // .  在前面和后面都无效
        return NO;
    }
    
    //判断是否只包含数字和点  应该为浮点字符串
    NSString *passWordRegex = @"^[0-9.]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:floatString];
}
+ (BOOL) validateCarNo:(NSString*)carNo{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        NSLog(@"carTest is %@",carTest); 
    return [carTest evaluateWithObject:carNo];
}


#pragma mark ----------StringSizeReturn----------
- (CGSize)sizeUnderWidth:(float)width AndFont:(UIFont*)font
{
    NSString *string = [self copy];
    CGSize size = CGSizeMake(0, 0);
    if (string == nil || [string length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSAttributedString *attributedText =[[NSAttributedString alloc]
                                             initWithString:string
                                             attributes:@{ NSFontAttributeName:font}];
        size = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            context:nil].size;
    }
    else
    {
        size = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}
- (CGSize)sizeUnderFont:(UIFont*)font
{
    NSString *string = [self copy];
    CGSize size = CGSizeMake(0, 0);
    if (string == nil || [string length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        size = [string sizeWithAttributes:@{ NSFontAttributeName:font}];
    }
    else
    {
        size = [string sizeWithFont:font];
    }
    return size;
}



#pragma mark ----------StringShiftUrl----------
- (NSURL *)url{
    return [NSURL URLWithString:self];
}
@end
