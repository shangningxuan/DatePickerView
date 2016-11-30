//
//  ZLDatePickerView.h
//  ThreePersonality
//
//  Created by Liang on 15/7/24.
//  Copyright (c) 2015年 zhiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLDatePickerView;
@protocol ZLPickerViewDelegate <NSObject>
@optional

- (void)datePickerView:(ZLDatePickerView *)pickView didSelectDate:(NSDate *)date;

@end

@interface ZLDatePickerView : UIView
@property(nonatomic,weak) id<ZLPickerViewDelegate> delegate;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
-(void)show;
@end
