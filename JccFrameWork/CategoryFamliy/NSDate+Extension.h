//
//  NSDate+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

#pragma mark ------------------------------
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)numDaysInMonth;



#pragma mark ------------------------------
+ (NSString *)currentTimeString;
+ (NSString *)currentFullTimeString;
+ (NSString *)currentDetailTimeString;



#pragma mark ------------------------------
+ (NSDate*)dateWithString:(NSString*)dateString
             formatString:(NSString*)dateFormatterString;
+ (NSDate*)dateWithDateString:(NSString*)str;
+ (NSDate*)dateWithDateTimeString:(NSString*)str;



#pragma mark ------------------------------
- (NSString *)formatStringWithFormat:(NSString *)formatString;
+ (NSString *)dateFormTimestampString:(NSString *)timestamp;
+ (NSString *)dateFormmterFormSecond:(int)count;



#pragma mark ------------------------------
- (NSString*)formattedExactRelativeDate;



#pragma mark ------------------------------
+ (NSString *)pastDateStringWith:(int)days;
+ (NSString *)futureDateStringWith:(int)days;
+ (NSString *)pastMonthDateStringWith:(int)months;
+ (NSString *)futureMonthDateStringWith:(int)months;
+ (NSString *)pastYearDateStringWith:(int)years;
+ (NSString *)futureYearDateStringWith:(int)years;



#pragma mark ------------------------------
- (BOOL)isPastDate;
- (BOOL)isDateToday;
- (BOOL)isDateYesterday;
@end
