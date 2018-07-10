//
//  KLCarouselView.m
//  Lunbo
//
//  Created by juwangkeji on 2018/7/10.
//  Copyright © 2018年 juwangkeji. All rights reserved.
//

#import "KLCarouselView.h"
#import "KLCarouselCell.h"
#import "KLconst.h"

@interface KLCarouselView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView * myCollectionView;
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) UIPageControl * pageControl;//圆点
@property(nonatomic,strong) NSTimer * timer;//定时器
@end

@implementation KLCarouselView

#pragma mark - initFunc
/**
  传入轮播图片的名字（数组）,默认滚动时间为2s
 */
-(instancetype)initWithImgNameArray:(NSMutableArray *)nameArray frame:(CGRect)m_frame{
    NSMutableArray * tempArray = [NSMutableArray arrayWithArray:nameArray];
    [tempArray insertObject:tempArray.lastObject atIndex:0];
    [tempArray insertObject:tempArray.firstObject atIndex:tempArray.count];
    self.dataArray = tempArray;
    return [self initWithFrame:m_frame];
}

+(instancetype)cosViewImgNameArray:(NSMutableArray *)nameArray frame:(CGRect)m_frame{
    return [[self alloc] initWithImgNameArray:nameArray frame:m_frame];
}

#pragma mark - setter / getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.myCollectionView.center.x,__KLVIEWHEIGHT__-25, 0, 25)];
        _pageControl.numberOfPages = self.dataArray.count-2;
        _pageControl.pageIndicatorTintColor = self.cos_pageIndicatorTintColor?:[UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = self.cos_currentPageIndicatorTintColor?:[UIColor redColor];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(__KLVIEWWIDTH__, __KLVIEWHEIGHT__);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, __KLVIEWWIDTH__, __KLVIEWHEIGHT__) collectionViewLayout: layout];
        _myCollectionView.pagingEnabled = YES;
        _myCollectionView.alwaysBounceVertical = NO;
        [_myCollectionView registerClass:[KLCarouselCell class] forCellWithReuseIdentifier:__KLCEllID__];
    }
    return _myCollectionView;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.waitTime?:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
    return _timer;
}
#pragma mark - initUI
-(void)setupUI{
    [self addSubview:_pageControl];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    //开始就先滚到-1
    NSIndexPath * index = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.myCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self addSubview:self.myCollectionView];
    [self addSubview:self.pageControl];
    [self addTimer];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - personal func
-(void)addTimer{
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)nextPage{
    NSIndexPath * index = [[self.myCollectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath * nextindex = [NSIndexPath indexPathForRow:index.item+1 inSection:0];
    
    self.pageControl.currentPage = index.item;
    if (nextindex.item==self.dataArray.count-1) {
        nextindex = [NSIndexPath indexPathForRow:0 inSection:0];
        self.pageControl.currentPage = 0;
        //偷偷滚到看不见那张，然后再光明正大的滚回第一张
        [self.myCollectionView scrollToItemAtIndexPath:nextindex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        nextindex = [NSIndexPath indexPathForRow:nextindex.item+1 inSection:0];
    }
    if (nextindex.item == 0) {
        nextindex = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
        self.pageControl.currentPage = 7;
        [self.myCollectionView scrollToItemAtIndexPath:nextindex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        nextindex = [NSIndexPath indexPathForRow:nextindex.item-1 inSection:0];
    }
    
    [self.myCollectionView scrollToItemAtIndexPath:nextindex atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - dataSource & delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLCarouselCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:__KLCEllID__ forIndexPath:indexPath];
    if (!cell) {
        cell = [[KLCarouselCell alloc] initWithFrame:self.myCollectionView.frame];
    }
    cell.imageName = self.dataArray[indexPath.row%self.dataArray.count];
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage =  ((int)scrollView.contentOffset.x/self.myCollectionView.frame.size.width)-1;
}


@end
