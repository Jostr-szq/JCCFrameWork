//
//  NSObject+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "NSObject+Extension.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <objc/objc.h>
#import <objc/runtime.h>
@implementation NSObject (Extension)

//static char kDTActionHandlerClickKey;

#pragma mark --------------------------------------------
#pragma mark 判断是否为数字(小数点)
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark --------------------------------------------
#pragma mark 发送短信
-(void)showSMSPicker:(NSDictionary *)content andViewController:(id )controller{
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    
    
    if (messageClass != nil) {
        
        // Check whether the current device is configured for sending SMS messages
        
        if ([messageClass canSendText]) {
            
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            
            picker.messageComposeDelegate =controller;
            
            NSString *smsBody =[NSString stringWithFormat:@"%@\n下载链接:%@",[content valueForKey:@"title"],[content valueForKey:@"url"]] ;
            //            picker.title = [content valueForKey:@"title"];
            picker.body = smsBody;
            
            [controller presentViewController:picker animated:YES completion:^{
                
            }];
            
            
        }
        
        else {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持短信功能" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
            
            [alert show];
        }
        
    }
    
    else {
        
    }
    
}


#pragma mark ----------Call&SMS&Email----------
- (void)callTo:(NSString *)phoneNo{
    NSString * mobile = [[NSString alloc] initWithFormat:@"tel://%@",phoneNo];
    NSURL * phoneUrl = [NSURL URLWithString:mobile];
    UIWebView * phoneCallWebView = [[UIWebView alloc] init];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneUrl]];
    [[UIApplication sharedApplication].delegate.window addSubview:phoneCallWebView];
}

- (void)sendMessage:(NSString *)info
{
    NSString *string = [NSString stringWithFormat:@"sms://%@",info];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:string]];
}

- (void)emailTo:(NSString *)mailAddress
{
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
    [mailUrl appendString:@"&subject=my email"];
    //添加邮件内容
    [mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}



#pragma mark --------------------------------------------
#pragma mark 存储设备唯一标识

//-(void) setKeyChainValue
//{
//    KeychainItemWrapper *keyChainItem=[[KeychainItemWrapper alloc]initWithIdentifier:@"TestUUID" accessGroup:nil];
//    NSString *strUUID = [keyChainItem objectForKey:(__bridge_transfer id)kSecAttrService];
//    if (strUUID==nil||[strUUID isEqualToString:@""])
//    {
//        [keyChainItem setObject:[self gen_uuid] forKey:(__bridge_transfer id)kSecAttrService];
//        [self setKeyChainValue];
//    }
//    //    [keyChainItem release];
//    
//}
//
//-(NSString *) gen_uuid
//{
//    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
//    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
//    CFRelease(uuid_ref);
//    NSString *uuid=[NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
//    CFRelease(uuid_string_ref);
//    return uuid;
//}
//
//-(void)deleteKeyChainValue
//{
//    KeychainItemWrapper *keyChainItem=[[KeychainItemWrapper alloc]initWithIdentifier:@"TestUUID" accessGroup:nil];
//    [keyChainItem resetKeychainItem];
//}
//
//
//
//-(void)setBackGroundCancleButton:(CGRect)frame andBlock:(TouchBackGPressBlock)block
//{
//    
//    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancleBtn.frame = frame;
//    cancleBtn.backgroundColor = [UIColor colorWithHue:200/255.0 saturation:200/255.0 brightness:200/255.0 alpha:0.5];
//    [cancleBtn addTarget:self action:@selector(cancleBackground:) forControlEvents:UIControlEventTouchUpInside];
//    [APPLICATIONDELEGATE.window addSubview:cancleBtn];
//    
//    if (block) {
//        ////移除所有关联
//        objc_removeAssociatedObjects(self);
//        /**
//         1 创建关联（源对象，关键字，关联的对象和一个关联策略。)
//         2 关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
//         3 关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。
//         */
//        objc_setAssociatedObject(self, &kDTActionHandlerClickKey, block, OBJC_ASSOCIATION_COPY);
//    }
//    //    self.blockPress = block;
//}
//
//-(void)cancleBackground:(id)sender
//{
//    TouchBackGPressBlock block = objc_getAssociatedObject(self, &kDTActionHandlerClickKey);
//    if (block) {
//        UIButton *button = (UIButton *)sender;
//        [button removeFromSuperview];
//        block();
//    }
//}




@end
