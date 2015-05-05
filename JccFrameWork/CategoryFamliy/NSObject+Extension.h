//
//  NSObject+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^TouchBackGPressBlock)(void);

@interface NSObject (Extension)


//@property (nonatomic,strong) TouchBackGPress blockPress;

//-(void)setBackGroundCancleButton:(CGRect)frame andBlock:(TouchBackGPressBlock)block;

/**
 *  判断是否为数字(小数点)
 *
 *  @param string string
 *
 *  @return bool
 */
- (BOOL)isPureNumandCharacters:(NSString *)string;

/**
 *  发送短信
 *
 *  @param content    内容加title
 *  @param controller self
 */
-(void)showSMSPicker:(NSDictionary *)content andViewController:(id )controller;

#pragma mark ------------------------------
/**
 *  打电话
 *
 *  @param phoneNo 电话号码
 */
- (void)callTo:(NSString *)phoneNo;

/**
 *  发短信
 *
 *  @param info 短信信息
 */
- (void)sendMessage:(NSString *)info;

/**
 *  写邮件
 *
 *  @param mailAddress 邮件地址
 */
- (void)emailTo:(NSString *)mailAddress;

#pragma mark --------------------------------------------
//-(void)setKeyChainValue;



@end
