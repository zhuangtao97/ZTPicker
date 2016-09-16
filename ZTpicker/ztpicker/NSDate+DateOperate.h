//
//  NSDate+DateOperate.h
//  Weather
//
//  Created by Feinno on 15/9/28.
//  Copyright © 2015年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateOperate)
//本地local时间
-(NSDate *)getCurrentDate;
+(NSDate *)getCurrentDate:(NSDate *)date;
-(NSString *)getDateOfyyyyMMdd:(NSDate *)inputDate;
+(NSString *)getDate:(NSDate *)inputDate andDateFormat:(NSString *)dateFormat;
//特定格式的date
+(NSString *)getCurrentDataStatus:(NSString *)compraeStr; //判断24小时内当前时间是今天，或者昨天
+(NSDate *)stringChangeDate:(NSString *)strDate;
//字符串转化为时间
//判断今天昨天
+(NSString *)getDayStatus:(NSString *)compraeStr;
//将1，2，3.... 转化为一，二....
+(NSString *)getMonthChineseStr:(NSString *)compraeStr;
+ (int)howManyDaysInThisMonth:(int)year month:(int)imonth;
@end
