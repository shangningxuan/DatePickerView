//
//  ZLDatePickerView.m
//  ThreePersonality
//
//  Created by Liang on 15/7/24.
//  Copyright (c) 2015年 zhiliang. All rights reserved.
//

#import "ZLDatePickerView.h"


@interface ZLDatePickerView()

@property (nonatomic, weak) UIView *pkView;
@property(nonatomic,strong) UIDatePicker *datePicker;

@end


#define LZLToobarHeight 40
// 每个按钮的高度
#define BtnHeight 46
// 取消按钮上面的间隔高度
#define Margin 1

#define HJCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
// 背景色
#define GlobelBgColor HJCColor(237, 240, 242)
// 分割线颜色
#define GlobelSeparatorColor HJCColor(226, 226, 226)
// 普通状态下的图片
#define normalImage [self createImageWithColor:HJCColor(255, 255, 255)]
// 高亮状态下的图片
#define highImage [self createImageWithColor:HJCColor(242, 242, 242)]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ZLDatePickerView


-(instancetype)init
{
    self=[super init];
    if (self) {
        
        // 黑色背景遮盖
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
        tap.delegate = (id)self;
        [self addGestureRecognizer:tap];
        

        //pickerview
        UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 0)];
        sheetView.backgroundColor = [UIColor lightGrayColor];
        sheetView.alpha = 1.0;
        [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
        self.pkView = sheetView;
        sheetView.hidden = YES;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sheetView.frame.size.width, 40)];
        topView.backgroundColor=  GlobelBgColor;
        topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [sheetView addSubview:topView];
        
        //tool
        UIButton *cancleButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 30)];
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        cancleButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        [self.pkView addSubview:cancleButton];
        
        UIButton *sureButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40-10, 5, 40, 30)];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [sureButton addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
        [self.pkView addSubview:sureButton];
        
        
        UIDatePicker *pickView=[[UIDatePicker alloc] init];
        pickView.datePickerMode=UIDatePickerModeDate;
        pickView.backgroundColor=[UIColor whiteColor];
        _datePicker=pickView;
        pickView.frame=CGRectMake(0, LZLToobarHeight, ScreenWidth, pickView.frame.size.height);
        [self.pkView addSubview:pickView];
        
    }
    return self;
    
}

//设置最小日期
-(void)setMinDate:(NSDate *)minDate
{
    if (_minDate != minDate) {
        _minDate = minDate;
        self.datePicker.minimumDate = minDate;
    }
}

//设置最大日期
-(void)setMaxDate:(NSDate *)maxDate
{
    if (_maxDate != maxDate) {
        _maxDate = maxDate;
        self.datePicker.maximumDate = maxDate;
    }
}

-(void)cancle
{
    [self coverClick];
}
-(void)makeSure
{
    [self coverClick];
    if (_delegate) {
        
        [_delegate datePickerView:self didSelectDate:_datePicker.date];
        
    }
}

- (void)show{
    
    NSLog(@"===%@",NSStringFromCGRect( self.pkView.frame));
    self.pkView.hidden = NO;
    CGRect newFrame = self.pkView.frame;
    newFrame.origin.y =ScreenHeight-self.datePicker.frame.size.height-LZLToobarHeight;
    newFrame.size.height=self.datePicker.frame.size.height+LZLToobarHeight;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.pkView.frame = newFrame;
        //self.alpha = 0.1;
        // NSLog(@"===%@",NSStringFromCGRect( self.pkView.frame));
    }];
}

- (void)coverClick{
    CGRect newFrame = self.pkView.frame;
    newFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.pkView.frame = newFrame;
        //self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.pkView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
@end
