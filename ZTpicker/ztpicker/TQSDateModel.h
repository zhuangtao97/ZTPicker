//
//  TQSDateModel.h
//  Weather
//
//  Created by feinno-sunao on 16/5/19.
//  Copyright © 2016年 feinno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQSDateModel : NSObject
/*
 阴历
 */
@property (nonatomic,strong) NSString *lunarCalendar;

/*
阳历
 */
@property (nonatomic,assign) int gregorianCalendar;

/*
当前月
 */
@property (nonatomic,assign) int currentMonth;
//当前日期 @“yyyy-MM-dd”
@property (nonatomic,copy)NSString *dateString;
@end
