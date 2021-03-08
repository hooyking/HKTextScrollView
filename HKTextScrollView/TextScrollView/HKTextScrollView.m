//
//  HKTextScrollView.m
//  HKTextScrollView
//
//  Created by hooyking on 2020/4/13.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKTextScrollView.h"
#import "HKTextScrollCollectionViewCell.h"

static NSString *const kTextScrollCollectionCellId = @"HKTextScrollCollectionViewCell";

@interface HKTextScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) HKTextScrollDirection scrollType;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation HKTextScrollView

- (instancetype)initWithFrame:(CGRect)frame scrollType:(HKTextScrollDirection)scrollType {
    if (self == [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        if (scrollType == HKTextScrollDirectionHorizontal) {
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else {
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerNib:[UINib nibWithNibName:kTextScrollCollectionCellId bundle:nil] forCellWithReuseIdentifier:kTextScrollCollectionCellId];
        self.collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
    }
    return self;
}

+ (instancetype)initWithVertivalTextArray:(NSArray *)textArray timeInterval:(NSTimeInterval)timeInterval frame:(CGRect)frame scrollType:(HKTextScrollDirection)scrollType selectBlock:(SelectedBlock)selectBlock {
    HKTextScrollView *textScrollView = [[HKTextScrollView alloc] initWithFrame:frame scrollType:scrollType];
    if (scrollType == HKTextScrollDirectionHorizontal) {
        textScrollView.timeInterval = fabs(timeInterval);
    } else {
        textScrollView.timeInterval = fabs(timeInterval);
    }
    textScrollView.selectedBlock = selectBlock;
    textScrollView.scrollType = scrollType;
    textScrollView.textArray = textArray;
    return textScrollView;
}

#pragma mark - UICollectionViewDelegateAndDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HKTextScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTextScrollCollectionCellId forIndexPath:indexPath];
    cell.titleLabel.text = self.textArray[indexPath.row];
    cell.titleLabel.textColor = self.textColor ? self.textColor : [UIColor blackColor];
    cell.titleLabel.font = self.textFont ? self.textFont : [UIFont systemFontOfSize:14];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scrollType == HKTextScrollDirectionHorizontal) {
        NSString *string = self.textArray[indexPath.row];
        CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont ? self.textFont : [UIFont systemFontOfSize:14]} context:nil].size;
        return CGSizeMake(size.width > self.bounds.size.width ? size.width+100 : self.bounds.size.width, self.bounds.size.height);
    }
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.scrollType == HKTextScrollDirectionVertical) {
        if (self.currentIndex == self.textArray.count) {
            self.currentIndex = 0;
            [self.collectionView setContentOffset:CGPointZero animated:NO];
        }
    }
}

- (void)timeLoop {
    if (self.scrollType == HKTextScrollDirectionHorizontal) {
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset];
        if (!(indexPath.section == 1 && indexPath.row == 0)) {
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x+1, 0) animated:NO];
        } else {
            [self.collectionView setContentOffset:CGPointZero animated:NO];
        }
    } else {
        self.currentIndex ++;
        [self.collectionView setContentOffset:CGPointMake(0, self.currentIndex * self.collectionView.bounds.size.height) animated:YES];
    }
}

- (void)start {
    self.timer.fireDate = [NSDate distantPast];
}

- (void)stop {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Setter
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    self.currentIndex = 0;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(timeLoop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.collectionView.backgroundColor = backgroundColor;
}

@end

