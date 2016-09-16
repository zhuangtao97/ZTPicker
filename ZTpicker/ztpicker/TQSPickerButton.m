//
//  TQSPickerButton.m
//  Weather
//
//  Created by feinno-sunao on 16/5/19.
//  Copyright © 2016年 feinno. All rights reserved.
//

#import "TQSPickerButton.h"
#import "UIView+Extension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define FONT_SIZE(a) [UIFont systemFontOfSize:(a)]
@implementation TQSPickerButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = (SCREEN_WIDTH - 30 - 8*5) / 7  * 0.5;
        UILabel *greLabel = [[UILabel alloc] init];
        greLabel.textAlignment = NSTextAlignmentCenter;
        greLabel.textColor = [UIColor grayColor];
        greLabel.font = FONT_SIZE(15);
        self.greLabel = greLabel;
        [self addSubview:greLabel];
        
        //阴历
        UILabel *lunarLabel = [[UILabel alloc] init];
        lunarLabel.textAlignment = NSTextAlignmentCenter;
        lunarLabel.textColor = [UIColor lightGrayColor];
        lunarLabel.font = FONT_SIZE(8);
        self.lunarLabel = lunarLabel;
        [self addSubview:lunarLabel];
    }
    return self;
}
- (void)layoutSubviews{
    
    self.greLabel.frame = CGRectMake(0, 5, self.width, 20);
    self.lunarLabel.frame = CGRectMake(0, self.greLabel.height + 1, self.width, 12);
    
}
@end
