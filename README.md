# HKTextScrollView

<div align=center><img src="https://github.com/hooyking/HKTextScrollView/blob/master/textScroll.gif?raw=true" width="372" height="261" /></div>

# 使用方法

水平滚动
```
HKTextScrollView *horizontalTextView = [HKTextScrollView initWithVertivalTextArray:@[@"052牛逼克拉斯",@"055自古以来",@"10艘航母你的就是我的，我的还是我的"] timeInterval:0.001 frame:CGRectMake(0, 100, kScreenW, 40) scrollType:HKTextScrollDirectionHorizontal selectBlock:^(NSInteger index) {
    NSLog(@"%zd",index);
}];
horizontalTextView.textColor = [UIColor blueColor];
horizontalTextView.backgroundColor = [UIColor redColor];
[self.view addSubview:horizontalTextView];
```
垂直滚动
```
HKTextScrollView *verticalTextView = [HKTextScrollView initWithVertivalTextArray:@[@"052牛逼克拉斯",@"055自古以来",@"10艘航母你的就是我的，我的还是我的"] timeInterval:2 frame:CGRectMake(0, 180, kScreenW, 40) scrollType:HKTextScrollDirectionVertical selectBlock:^(NSInteger index) {
    NSLog(@"%zd",index);
}];
verticalTextView.textColor = [UIColor orangeColor];
verticalTextView.backgroundColor = [UIColor grayColor];
[self.view addSubview:verticalTextView];
```
里面cell可以自定义

可以直接把TextScrollView文件夹拖入项目直接使用
