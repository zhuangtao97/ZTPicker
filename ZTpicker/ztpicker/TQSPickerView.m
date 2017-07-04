//
//  TQSPickerView.m
//  Weather
//
//  Created by feinno-sunao on 16/5/19.
//  Copyright © 2016年 feinno. All rights reserved.
//


#define viewWidth SCREEN_WIDTH - 30
//行
#define DateMaxRows 6
// 表情的最大列数
#define DateMaxCols 7

#define margin 10

#define btnWidth (SCREEN_WIDTH - 30 - 8 * margin * 0.5) / 7
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "TQSPickerView.h"
#import "TQSDateModel.h"
#import "TQSPickerButton.h"
#import "NSDate+DateOperate.h"
#import "UIView+Extension.h"
@interface TQSPickerView()

@property (nonatomic,strong)UIView *toolBar;

@property (nonatomic,strong)UIView *dateView;


@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIView *headerView;


@end

@implementation TQSPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        
        UIView *toolBar = [[UIView alloc] init];
        [self addSubview:toolBar];
        self.toolBar = toolBar;
        
        UIButton *leftBtn =[[UIButton alloc] init];
        self.leftBtn = leftBtn;
        [leftBtn setTitle:@"<" forState:UIControlStateNormal];
         [leftBtn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        leftBtn.tag = 100;
        [leftBtn addTarget:self action:@selector(otherPage:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:self.leftBtn];
        
        UIButton *rightBtn =[[UIButton alloc] init];
        self.rightBtn = rightBtn;
        [rightBtn setTitle:@">" forState:UIControlStateNormal];
        rightBtn.tag = 200;
         [rightBtn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(otherPage:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:self.rightBtn];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [toolBar addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor redColor];
        titleLabel.text = @"2016-05";
        
        UIView *headerView = [[UIView alloc] init];
        self.headerView = headerView;
        [toolBar addSubview:headerView];
        
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [[UIButton alloc] init];
            [headerView addSubview:btn];
            
            
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self setHeaderBtnTitle:btn index:i];
            [btn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
        UIView *dateView = [[UIView alloc] init];
        self.dateView = dateView;
        [self addSubview:dateView];
        
        for (int i = 0; i < 42; i++) {
            TQSPickerButton *btn = [[TQSPickerButton alloc] init];
            [self.dateView addSubview:btn];
//            btn.backgroundColor = [UIColor blueColor];
            [btn addTarget:self action:@selector(choosedDate:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0f];
    
    [self initCurrentDate];
    
    return self;
}
- (void)initCurrentDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    int currentYear = (int)[components year];  //当前的年份
    
    int currentMonth = (int)[components month];  //当前的月份
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d年%d月",currentYear,currentMonth];
}
- (void)choosedDate:(TQSPickerButton *)btn{
    

    [self reSetPickerState];
    
    btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:83/255.0 blue:75/255.0 alpha:1.0f];
    btn.greLabel.textColor = [UIColor whiteColor];
    btn.lunarLabel.textColor = [UIColor whiteColor];
    
    TQSDateModel *dateModel = self.daysArr[btn.tag];
    NSLog(@"%@",dateModel.dateString);
    if (_delegate && [_delegate respondsToSelector:@selector(selectedDate:andSelectedDate:)]) {
        [_delegate selectedDate:self andSelectedDate:dateModel.dateString];
    }
}
//重置日期的状态
- (void)reSetPickerState{
    for (int i = 0 ; i < 42; i++) {
        TQSPickerButton *allBtn = self.dateView.subviews[i];
        allBtn.backgroundColor = [UIColor clearColor];
        allBtn.greLabel.textColor = [UIColor grayColor];
        allBtn.lunarLabel.textColor = [UIColor lightGrayColor];
    }
}
- (void)otherPage:(UIButton *)btn{
    if (btn.tag == 100) {
        if (_delegate && [_delegate respondsToSelector:@selector(leftPage:)]) {
            [_delegate leftPage:self];
        }
        //左
    }else{
       //右
        if (_delegate && [_delegate respondsToSelector:@selector(rightPage:)]) {
            [_delegate rightPage:self];
        }
    }
}
- (void)layoutSubviews{
    
    self.toolBar.frame = CGRectMake(0, 0, viewWidth, 80);
    
    self.leftBtn.frame = CGRectMake(0, 0, 50, 50);
    self.rightBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - 50, 0, 50, 50);
    self.titleLabel.frame = CGRectMake(self.leftBtn.width, 0, SCREEN_WIDTH - self.leftBtn.width * 2 - 30, 50);
    
    self.headerView.frame = CGRectMake(0, 50, SCREEN_WIDTH - 30, 30);
    for (int i = 0; i < 7; i++) {
        UIButton *btn = self.headerView.subviews[i];
        btn.x = margin - (margin * 0.5) + (i % DateMaxCols) * (btnWidth + margin * 0.5);

        btn.y = (i / DateMaxCols) * (btnWidth) ;
        btn.width = btnWidth;
        btn.height = 30;
    }
    
    self.dateView.frame = CGRectMake(0, 80, viewWidth, btnWidth * 7);
    
    for (int i = 0; i < 42; i++) {
        TQSPickerButton *btn = self.dateView.subviews[i];
        btn.x = margin - (margin * 0.5) + (i % DateMaxCols) * (btnWidth + margin * 0.5) ;

        btn.y = (i / DateMaxCols) * (btnWidth) ;
        btn.width =  btnWidth;
        btn.height = btnWidth;
    }

 
}
- (void)setDaysArr:(NSMutableArray *)daysArr{
    
    _daysArr = daysArr;
    
    TQSDateModel *firstDate = daysArr[0];
    
    NSInteger a = [self calculateWeek:firstDate.dateString];
    
    
    for (int i = 0; i < self.dateView.subviews.count ; i++) {
        [self reSetPickerState];
        TQSPickerButton *btn = self.dateView.subviews[i];
        btn.hidden = YES;
    }
    for (int i = 0; i < daysArr.count ; i++) {

        
        TQSDateModel *dateModel = daysArr[i];
        
        TQSPickerButton *btn = self.dateView.subviews[i + a];
        btn.tag = i;
        btn.greLabel.text = [NSString stringWithFormat:@"%d",dateModel.gregorianCalendar];
        btn.lunarLabel.text = dateModel.lunarCalendar;
        btn.hidden = NO;
        //选择当前月当前天
        
        NSLog(@"%d---%ld",dateModel.currentMonth,[self isCurrentMonth]);
        
        if (i+1 == [self isCurrentDay] && [self isCurrentMonth] == dateModel.currentMonth) {
            
            [self choosedDate:btn];
        }
    }
}
- (NSInteger)isCurrentDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    return components.day;
}
- (NSInteger)isCurrentMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    return components.month;
}


- (NSInteger)calculateWeek:(NSString *)aStrDate{
    //计算week数
    NSDate *dateTemp = nil;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    dateTemp = [dateFormater dateFromString:aStrDate];
    
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSWeekdayCalendarUnit fromDate:dateTemp] weekday];
    return week - 1;
}
- (void)setHeaderBtnTitle:(UIButton *)btn index:(int)index{
    switch (index) {
        case 0:
            [btn setTitle:@"日" forState:UIControlStateNormal];
            break;
        case 1:
            [btn setTitle:@"一" forState:UIControlStateNormal];
            break;
        case 2:
            [btn setTitle:@"二" forState:UIControlStateNormal];
            break;
        case 3:
            [btn setTitle:@"三" forState:UIControlStateNormal];
            break;
        case 4:
            [btn setTitle:@"四" forState:UIControlStateNormal];
            break;
        case 5:
            [btn setTitle:@"五" forState:UIControlStateNormal];
            break;
        case 6:
            [btn setTitle:@"六" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
- (void)show{

    [UIView animateWithDuration:0.25 animations:^{

        self.frame = CGRectMake(15, 180, SCREEN_WIDTH - 30, SCREEN_WIDTH - 10);
        
        
        [self.superview layoutIfNeeded];
        
    }];
    
    
}
- (void)hidden{

 
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(15, 180, 0, 0);
        [self.superview layoutIfNeeded];
        
    } completion:^(BOOL finished) {
    
        [self initCurrentDate];
    }];
    
}

@end
