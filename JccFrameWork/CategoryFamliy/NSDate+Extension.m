//
//  NSDate+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "NSDate+Extension.h"


@implementation NSDate (Extension)

#pragma mark ----------DateProperty----------
- (NSInteger)year{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
    
}

- (NSInteger)month{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
    
}

- (NSInteger)day{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
    
}

- (NSInteger)numDaysInMonth{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}




#pragma mark ----------CurrentTimeString----------
+ (NSString *)currentTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentFullTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentDetailTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}




#pragma mark ----------DateFromString----------
+ (NSDate*)dateWithString:(NSString*)dateString formatString:(NSString*)dateFormatterString {
	if(!dateString) return nil;
	
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormatterString];
	
	NSDate *theDate = [formatter dateFromString:dateString];
    
	return theDate;
}

+ (NSDate*)dateWithDateString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM-dd"];
}

+ (NSDate*)dateWithDateTimeString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM-dd HH:mm:ss"];
}



#pragma mark ----------DateStringWithCoustom----------
- (NSString *)formatStringWithFormat:(NSString *)formatString{
    
    if (formatString.length == 0) {
        return @"";
    }
    //@"yyyy-MM-dd"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    return [dateFormatter stringFromDate:self];
}


+ (NSString *)dateFormTimestampString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:MM"];
    
    return [formatter stringFromDate:confromTimsp];
}

+ (NSString *)dateFormmterFormSecond:(int)count{
    int laveCounts = count;
    int days = laveCounts/(60*60*12);
    laveCounts = laveCounts - days*(60*60*12);
    
    int hours = laveCounts/(60*60);
    laveCounts = laveCounts - hours*(60*60);
    
    int minutes = laveCounts/60;
    laveCounts = laveCounts - minutes*60;
    
    int second = laveCounts;
    
    return [NSString stringWithFormat:@"%d天%d小时%d分%d秒",days,hours,minutes,second];
}



#pragma mark ----------DateStringExactSetting----------
- (NSString*)formattedDateWithFormatString:(NSString*)dateFormatterString {
	if(!dateFormatterString) return nil;
	
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormatterString];
	[formatter setAMSymbol:@"am"];
	[formatter setPMSymbol:@"pm"];
	return [formatter stringFromDate:self];
}

- (NSString*)formattedExactRelativeDate{
    
    NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = now - time;
	
	if(diff < 10) {
        return [NSString stringWithFormat:@"刚刚"];
	} else if(diff < 60) {
        return [NSString stringWithFormat:@"%d秒前",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
		if(diff == 1) {
            return [NSString stringWithFormat:@"%d分钟前",(int)diff];
		} else {
            return [NSString stringWithFormat:@"%d分钟前",(int)diff];
		}
	}
	
	diff = round(diff/60);
	if(diff < 24) {
		if(diff == 1) {
            return [NSString stringWithFormat:@"%d小时前",(int)diff];
		} else {
            return [NSString stringWithFormat:@"%d小时前",(int)diff];
		}
	}
	
	if(diff < 7) {
		if(diff == 1) {
			return @"昨天";
		} else {
            return [NSString stringWithFormat:@"%d天前", (int)diff];
		}
	}
	
	return [self formattedDateWithFormatString:@"MM/dd/yy"];
}






#pragma mark ----------DateStringFrom----------
+ (NSString *)pastDateStringWith:(int)days{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:days*86400*-1];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)futureDateStringWith:(int)days{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:days*86400];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)pastMonthDateStringWith:(int)months{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1 * months];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}


+ (NSString *)futureMonthDateStringWith:(int)months{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:months];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)pastYearDateStringWith:(int)years{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-1 * years];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)futureYearDateStringWith:(int)years{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:years];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}


#pragma mark ----------TimeComparison----------
- (BOOL)isPastDate{
    NSDate* now = [NSDate date];
	if([[now earlierDate:self] isEqualToDate:self]) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)isDateToday{
    return [[[NSDate date] midnightDate] isEqual:[self midnightDate]];
}

- (BOOL)isDateYesterday{
    return [[[NSDate dateWithTimeIntervalSinceNow:-86400] midnightDate]
            isEqual:[self midnightDate]];
}

- (NSDate*)midnightDate {
	return [[NSCalendar currentCalendar] dateFromComponents:
            [[NSCalendar currentCalendar] components:
             (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self]];
}
@end
