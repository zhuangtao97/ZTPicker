//
//  TQSDateModel.m
//  Weather
//
//  Created by feinno-sunao on 16/5/19.
//  Copyright © 2016年 feinno. All rights reserved.
//

#import "TQSDateModel.h"


@interface TQSDateModel()


@end

@implementation TQSDateModel


- (void)setGregorianCalendar:(int)gregorianCalendar{
    _gregorianCalendar = gregorianCalendar;
    self.lunarCalendar = [self convertDateToNongLi:self.dateString];
}

//日期阳历转换为农历；
- (NSString *)convertDateToNongLi:(NSString *)aStrDate  {
    
    NSDate *dateTemp = nil;
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    
    dateTemp = [dateFormater dateFromString:aStrDate];
    
    NSCalendar* calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSChineseCalendar];
    
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dateTemp];
    
    NSString* nongliMonth = [NSString stringWithFormat:@"%ld",components.month - 1];
    
    NSString* nongliDay = [NSString stringWithFormat:@"%ld",components.day];
    
    NSString* nongliString = [NSString stringWithFormat:@"%@%@",nongliMonth,nongliDay];
    
    return [self translation:components.day];
}
- (NSString *)translation:(NSInteger)day
{
    switch (day) {
        case 1:
            return @"初一";
            break;
        case 2:
            return @"初二";
            break;
        case 3:
            return @"初三";
            break;
        case 4:
            return @"初四";
            break;
        case 5:
            return @"初五";
            break;
        case 6:
            return @"初六";
            break;
        case 7:
            return @"初七";
            break;
        case 8:
            return @"初八";
            break;
        case 9:
            return @"初九";
            break;
        case 10:
            return @"初十";
            break;
        case 11:
            return @"十一";
            break;
        case 12:
            return @"十二";
            break;
        case 13:
            return @"十三";
            break;
        case 14:
            return @"十四";
            break;
        case 15:
            return @"十五";
            break;
        case 16:
            return @"十六";
            break;
        case 17:
            return @"十七";
            break;
        case 18:
            return @"十八";
            break;
        case 19:
            return @"十九";
            break;
        case 20:
            return @"廿十";
            break;
        case 21:
            return @"廿一";
            break;
        case 22:
            return @"廿二";
            break;
        case 23:
            return @"廿三";
            break;
        case 24:
            return @"廿四";
            break;
            
        case 25:
            return @"廿五";
            break;
        case 26:
            return @"廿六";
            break;
        case 27:
            return @"廿七";
            break;
        case 28:
            return @"廿八";
            break;
        case 29:
            return @"廿九";
            break;
        case 30:
            return @"三十";
            break;
        case 31:
            return @"三一";
            break;
        default:
            break;
    }
    return @"";
}
@end
