//
//  ViewController.m
//  ZTpicker
//
//  Created by zhuangtao on 16/9/16.
//  Copyright © 2016年 zhuangtao. All rights reserved.
//

#import "ViewController.h"

#import "TQSPickerView.h"

#import "TQSDateModel.h"

#import "NSDate+DateOperate.h"

@interface ViewController ()<TQSPickerViewDelegate>

@property (nonatomic,strong)TQSPickerView *pickerView;

@property (nonatomic,assign)int currentYear;
@property (nonatomic,assign)int currentMonth;

@property (weak, nonatomic) IBOutlet UILabel *chooseDate;

@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //日期控件
    TQSPickerView *pickerView = [[TQSPickerView alloc] init];
    
    self.pickerView = pickerView;
    
    pickerView.delegate = self;
    
    pickerView.frame = CGRectMake(15, 180, SCREEN_WIDTH - 30, 0);
    
//    pickerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:pickerView];
    
    [self initCurrentDate];
    
    [self initPickerData];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)showBtn:(id)sender {
    
    [self initPickerData];
    
    [self.pickerView show];
}

- (IBAction)hiddenBtn:(id)sender {
    
    [self.pickerView hidden];
    
    [self initCurrentDate];
}

- (void)initCurrentDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    self.currentYear = (int)[components year];  //当前的年份
    
    self.currentMonth = (int)[components month];  //当前的月份
    
    int currentDay = (int)[components day];
    
    self.chooseDate.text = [NSString stringWithFormat:@"%d-%d-%d",self.currentYear,self.currentMonth,currentDay];

}

#pragma mark  TQSPickerViewDelegate 代理方法
//向左翻页
- (void)leftPage:(TQSPickerView *)pickerView{
    if (self.currentMonth == 1) {
        return;
    }
    self.currentMonth--;
    [self initPickerData];
}
//向右翻页
- (void)rightPage:(TQSPickerView *)pickerView{
    if (self.currentMonth == 12) {
        return;
    }
    self.currentMonth++;
    [self initPickerData];
}

- (void)selectedDate:(TQSPickerView *)pickerView andSelectedDate:(NSString *)dateStr{

    self.chooseDate.text = dateStr;
    
}
- (void)initPickerData{
    
    
    int days = [NSDate howManyDaysInThisMonth:self.currentYear month:self.currentMonth];
    
    self.pickerView.titleLabel.text = [NSString stringWithFormat:@"%d年%d月",self.currentYear,self.currentMonth];
    
    NSMutableArray *dateArr = [NSMutableArray array];
    
    for (int i =0 ; i<days; i++) {
        
        TQSDateModel *dateModel = [[TQSDateModel alloc] init];
        
        dateModel.dateString = [NSString stringWithFormat:@"%d-%d-%d",self.currentYear,self.currentMonth ,i + 1];
        
        dateModel.gregorianCalendar = i + 1;
        
        dateModel.currentMonth = self.currentMonth;
        
        [dateArr addObject:dateModel];
        
    }
    
    self.pickerView.daysArr = [dateArr copy];
}
@end
