//
//  TQSPickerView.h
//  Weather
//
//  Created by feinno-sunao on 16/5/19.
//  Copyright © 2016年 feinno. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TQSPickerView;
@protocol TQSPickerViewDelegate <NSObject>

@optional
- (void)leftPage:(TQSPickerView *)pickerView;
- (void)rightPage:(TQSPickerView *)pickerView;
- (void)selectedDate:(TQSPickerView *)pickerView andSelectedDate:(NSString *)dateStr;

@end

@interface TQSPickerView : UIView
@property (nonatomic,strong)NSMutableArray *daysArr;
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong) id<TQSPickerViewDelegate> delegate;


- (void)show;
- (void)hidden;

@end
