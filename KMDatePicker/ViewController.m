//
//  ViewController.m
//  KMDatePicker
//
//  Created by KenmuHuang on 15/10/6.
//  Copyright © 2015年 Kenmu. All rights reserved.
//

#import "ViewController.h"
#import "DateHelper.h"
#import "NSDate+CalculateDay.h"

@interface ViewController ()
{
    KMDatePicker *datePicker;
    NSMutableArray *datePickerArray;
}
- (void)layoutUI;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    datePickerArray = [NSMutableArray array];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)layoutUI {
    CGRect rect = [UIScreen mainScreen].bounds;
    // 年月日时分
    KMDatePicker *datePicker1 = [[KMDatePicker alloc]
                                initWithFrame:rect
                                delegate:self
                                datePickerStyle:KMDatePickerStyleYearMonthDayHourMinute];
    [datePickerArray addObject:datePicker1];
    
    // 年月日
    KMDatePicker *datePicker2 = [[KMDatePicker alloc]
                  initWithFrame:rect
                  delegate:self
                  datePickerStyle:KMDatePickerStyleYearMonthDay];
    [datePickerArray addObject:datePicker2];
    
    // 年月
    KMDatePicker *datePicker3 = [[KMDatePicker alloc]
                                 initWithFrame:rect
                                 delegate:self
                                 datePickerStyle:KMDatePickerStyleYearMonth];
    [datePickerArray addObject:datePicker3];
    
    // 月日时分
    KMDatePicker *datePicker4 = [[KMDatePicker alloc]
                  initWithFrame:rect
                  delegate:self
                  datePickerStyle:KMDatePickerStyleMonthDayHourMinute];
    [datePickerArray addObject:datePicker4];
    
    
    // 时分
    KMDatePicker *datePicker5 = [[KMDatePicker alloc]
                  initWithFrame:rect
                  delegate:self
                  datePickerStyle:KMDatePickerStyleHourMinute];
    [datePickerArray addObject:datePicker5];
    
    
    // 年月日时分；限制时间范围
    KMDatePicker *datePicker6 = [[KMDatePicker alloc]
                  initWithFrame:rect
                  delegate:self
                  datePickerStyle:KMDatePickerStyleYearMonthDayHourMinute];
    datePicker6.minLimitedDate = [[DateHelper localeDate] addMonthAndDay:-24 days:0];
    datePicker6.maxLimitedDate = [datePicker.minLimitedDate addMonthAndDay:48 days:0];
    [datePickerArray addObject:datePicker6];
    
    
    _txtFYearMonthDayHourMinute.delegate = self;
    _txtFYearMonthDayHourMinute.tag = 100;
    _txtFYearMonthDay.delegate = self;
    _txtFYearMonthDay.tag = 101;
    _txtFYearMonth.delegate = self;
    _txtFYearMonth.tag = 102;
    _txtFMonthDayHourMinute.delegate = self;
    _txtFMonthDayHourMinute.tag = 103;
    _txtFHourMinute.delegate = self;
    _txtFHourMinute.tag = 104;
    _txtFLimitedDate.delegate = self;
    _txtFLimitedDate.tag = 105;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    KMDatePicker *datePiker = [datePickerArray objectAtIndex:textField.tag - 100];
    [datePiker showInView:self.view];
    
    _txtFCurrent = textField;
}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate {
    NSString *dateStr = nil;
    switch (_txtFCurrent.tag) {
        case 100:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",
               datePickerDate.year,
               datePickerDate.month,
               datePickerDate.day,
               datePickerDate.hour,
               datePickerDate.minute
               ];
            break;
        case 101:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@",
                       datePickerDate.year,
                       datePickerDate.month,
                       datePickerDate.day
                       ];
            break;
        case 102:
            dateStr = [NSString stringWithFormat:@"%@-%@",
                       datePickerDate.year,
                       datePickerDate.month
                       ];
            break;
        case 103:
            dateStr = [NSString stringWithFormat:@"%@-%@ %@:%@",
                       datePickerDate.month,
                       datePickerDate.day,
                       datePickerDate.hour,
                       datePickerDate.minute
                       ];
            break;
        case 104:
            dateStr = [NSString stringWithFormat:@"%@:%@",
                       datePickerDate.hour,
                       datePickerDate.minute
                       ];
            break;
        case 105:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@ %@",
                       datePickerDate.year,
                       datePickerDate.month,
                       datePickerDate.day,
                       datePickerDate.hour,
                       datePickerDate.minute,
                       datePickerDate.weekdayName
                       ];
            break;
        default:
            break;
    }
    _txtFCurrent.text = dateStr;
}

@end
