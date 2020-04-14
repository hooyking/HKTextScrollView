//
//  ViewController.m
//  HKTextScrollView
//
//  Created by hooyking on 2020/4/13.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "ViewController.h"
#import "HKTextScrollView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文字滚动";
    
    HKTextScrollView *horizontalTextView = [HKTextScrollView initWithVertivalTextArray:@[@"052牛逼克拉斯",@"055自古以来",@"10艘航母你的就是我的，我的还是我的"] timeInterval:0.001 frame:CGRectMake(0, 100, kScreenW, 40) scrollType:HKTextScrollDirectionHorizontal selectBlock:^(NSInteger index) {
        NSLog(@"%zd",index);
    }];
    horizontalTextView.textColor = [UIColor blueColor];
    horizontalTextView.backgroundColor = [UIColor redColor];
    [self.view addSubview:horizontalTextView];
    
    HKTextScrollView *verticalTextView = [HKTextScrollView initWithVertivalTextArray:@[@"052牛逼克拉斯",@"055自古以来",@"10艘航母你的就是我的，我的还是我的"] timeInterval:2 frame:CGRectMake(0, 180, kScreenW, 40) scrollType:HKTextScrollDirectionVertical selectBlock:^(NSInteger index) {
        NSLog(@"%zd",index);
    }];
    verticalTextView.textColor = [UIColor orangeColor];
    verticalTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:verticalTextView];
}


@end
