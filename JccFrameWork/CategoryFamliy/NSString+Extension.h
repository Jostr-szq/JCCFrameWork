//
//  NSString+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

#pragma mark --------------------------------------------
-(NSString *)replaceArrStr:(NSArray *)proArr with:(NSString *)kerStr;

#pragma mark ------------------------------
- (BOOL)isExist;
- (NSString *)deleteWhitespaceAndWrapOnBothEnds;
- (NSString *)deleteAllWhitespaceAndWrap;
- (BOOL)hasSubstring:(NSString *)subString;


#pragma mark ------------------------------
+ (BOOL)validateMobilePhone:(NSString *)mobilePhone;
+ (BOOL)validateMobilePhoneTextFiled:(UITextField *)textFiled;
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateEmailTextFiled:(UITextField *)textFiled;
+ (BOOL)validateNumber:(NSString *)number;
+ (BOOL)validateStrictNumber:(NSString *)number;
+ (BOOL)validateTelephone:(NSString *)telephone;
+ (BOOL)validateIDCardNumber:(NSString *)value;
+ (BOOL)validateNickname:(NSString *)nickname;
+ (BOOL)validatePassword:(NSString *)passWord;
+ (BOOL)validatefloatString:(NSString *)floatString;
+ (BOOL) validateCarNo:(NSString*)carNo;



#pragma mark ------------------------------

- (CGSize)sizeUnderWidth:(float)width AndFont:(UIFont*)font;
- (CGSize)sizeUnderFont:(UIFont*)font;




#pragma mark ------------------------------
- (NSURL *)url;

@end
