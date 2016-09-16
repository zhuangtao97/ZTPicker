//
//  NSDate+DateOperate.m
//  Weather
//
//  Created by Feinno on 15/9/28.
//  Copyright © 2015年 feinno. All rights reserved.
//

#import "NSDate+DateOperate.h"

@implementation NSDate (DateOperate)
//本地local时间
-(NSDate *)getCurrentDate{

    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;

}
//本地local时间
+(NSDate *)getCurrentDate:(NSDate *)date{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
    
}

-(NSString *)getDateOfyyyyMMdd:(NSDate *)inputDate{

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyyMMdd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;

}
+(NSString *)getDate:(NSDate *)inputDate andDateFormat:(NSString *)dateFormat{

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [outputFormatter setDateFormat:dateFormat];
    NSString *str = [outputFormatter stringFromDate:inputDate ];
    return str;
                     

}
//24小时内
+(NSString *)getCurrentDataStatus:(NSString *)compraeStr{
    NSString *strStatus=@"";
    NSDate  *compareDate=[NSDate  stringChangeDate:compraeStr];
    NSDate *currentDate=[NSDate getCurrentDate:[NSDate date]];
    NSTimeInterval  timeInterval = [currentDate timeIntervalSinceDate:compareDate];
    if (timeInterval<24*60*60) {
//     判断是否为今天
      NSString *  strCurrentDate=[NSDate getDate:currentDate andDateFormat:@"yyyy-MM-dd"];
        strCurrentDate=[NSDate getDate:currentDate andDateFormat:@"yyyy-MM-dd"];
        strCurrentDate=[NSString stringWithFormat:@"%@ 00:00:00",strCurrentDate];
        NSDate *newCurrentDate=[NSDate stringChangeDate:strCurrentDate];
       newCurrentDate=[NSDate getCurrentDate:newCurrentDate];
       NSTimeInterval  newTimeInterval = [currentDate timeIntervalSinceDate:newCurrentDate];
        if (timeInterval<newTimeInterval) {
            strStatus=@"今天";
        }
        else{
         strStatus=@"昨天";
        
        }
        
    }
    
    return strStatus;

}
+(NSDate *)stringChangeDate:(NSString *)strDate{

    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"Asia/beijing"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:strDate];
    return inputDate;
}

//判断今天昨天
+(NSString *)getDayStatus:(NSString *)compraeStr{
    
    NSString *strStatus=@"";
    NSDate *currentDate=[NSDate getCurrentDate:[NSDate date]];
    NSString *  strCurrentDate=[NSDate getDate:currentDate andDateFormat:@"yyyy-MM-dd"];
    NSArray *arrCurrent= [strCurrentDate  componentsSeparatedByString:@"-"];
    NSArray *arrCompare=[compraeStr componentsSeparatedByString:@"-"];
 //  先比较第一位
  
    NSString  * currentDayStatus=arrCurrent[2]  ;
    NSString  *compareDayStatus=arrCompare[2] ;
//  如果第一位为0踢掉
    currentDayStatus=[[currentDayStatus substringToIndex:1] isEqualToString:@"0"]?[currentDayStatus substringFromIndex:1]:currentDayStatus;
    compareDayStatus=[[compareDayStatus substringToIndex:1] isEqualToString:@"0"]?[compareDayStatus substringFromIndex:1]:compareDayStatus;
    
    if ([arrCurrent[0] isEqualToString:arrCompare[0]]&&[arrCurrent[1] isEqualToString:arrCompare[1]]) {
        if ([currentDayStatus  longLongValue]-[compareDayStatus longLongValue]==1) {
            
            strStatus=@"昨天";
        }
        else  if ([currentDayStatus intValue]-[compareDayStatus  intValue]==0) {
            strStatus=@"今天";
        }
        else{
            strStatus=@"other";

        }
       
    }
    else{
    
    strStatus=@"other";
    }
    
    
    return strStatus;


}
//将1，2，3.... 转化为一，二....
+(NSString *)getMonthChineseStr:(NSString *)compraeStr{
    
    if (compraeStr.length==2&&[[compraeStr substringToIndex:1] isEqualToString:@"0"]) {
        compraeStr=[compraeStr  substringFromIndex:1];
    }
        
        NSInteger intCompare=[compraeStr  intValue]-1;
        NSArray *arrDay=@[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
        return arrDay[intCompare];
   

}
//查询某年某月天数
+ (int)howManyDaysInThisMonth:(int)year month:(int)imonth {
    
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
@end
