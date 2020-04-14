//
//  HKTextScrollView.h
//  HKTextScrollView
//
//  Created by hooyking on 2020/4/13.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HKTextScrollDirection){
    HKTextScrollDirectionHorizontal,
    HKTextScrollDirectionVertical
};

typedef void(^SelectedBlock)(NSInteger index);

@interface HKTextScrollView : UIView

/// 文字大小
@property (nonatomic, strong) UIFont *textFont;
/// 文字颜色
@property (nonatomic, strong) UIColor *textColor;
/// 背景色
@property (nonatomic, strong) UIColor *backgroundColor;
/// 时间间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, copy) SelectedBlock selectedBlock;

+ (instancetype)initWithVertivalTextArray:(NSArray *)textArray timeInterval:(NSTimeInterval)timeInterval frame:(CGRect)frame scrollType:(HKTextScrollDirection)scrollType selectBlock:(SelectedBlock)selectBlock;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
