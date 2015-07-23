//
//  BarViewController.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "BarViewController.h"
#import "CDBarChart.h"
#import "BarViewController1.h"
#import "CollectionViewCell.h"

@interface BarViewController ()<ChartBarDelegate, ChartBarDataSource> {
    CDBarChart *barChart;
}

@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 200);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200) collectionViewLayout:layout];
    _myCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    _myCollectionView.backgroundColor = [UIColor clearColor];
    _myCollectionView.showsHorizontalScrollIndicator = NO;
    _myCollectionView.pagingEnabled = YES;
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [_myCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_myCollectionView];
    
    barChart = [[CDBarChart alloc] initWithFrame:CGRectMake(0, 250, CGRectGetWidth(self.view.frame), 200) WithType:DidSelectTypeTouch];
    barChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    barChart.didSelectType = DidSelectTypeTouch;
    barChart.delegate = self;
    barChart.dataSource = self;
    
    
    [self.view addSubview:barChart];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSInteger index = CGRectGetMidX(cell.frame)  / CGRectGetWidth(cell.frame);
    CD_NSLog(@"^^^^^^^^%d",index);
    
    if (!cell.barChart) {
        cell.barChart = [[CDBarChart alloc] initWithFrame:cell.bounds WithType:DidSelectTypeTouch];
        cell.barChart.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cell.barChart.didSelectType = DidSelectTypeTouch;
        cell.barChart.showYCoordinate = NO;
        cell.barChart.delegate = self;
        cell.barChart.dataSource = self;

        [cell addSubview:cell.barChart];
    }else {
        [cell.barChart reloadData];
    }
    
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSInteger index = (scrollView.contentOffset.x + CGRectGetWidth(scrollView.frame)/2) / CGRectGetWidth(scrollView.frame);
//    CD_NSLog(@"===%d",index);
//}
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    CD_NSLog(@"*************");
//}

#pragma mark - ChartBarDataSource

- (NSArray *)arrayWithXCoordinateValue {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<24; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return array;
}

- (CGRange)rangeWithYCoordinateValue {
    return CGRangeMake(20, 10);
}

- (NSArray *)barYValues {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<24; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",(arc4random()%10) +10]];
    }
//    NSArray *yValue1 = @[@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20"];
    return @[array];
}

- (NSUInteger)countInYCoordinate {
    return 6;
}

- (NSArray *)barColorsInChart {
    return @[CDRandomColor];
}

- (CGFloat)barWidth {
    return 30;
}

#pragma mark - ChartBarDelegate

- (void)chartBarDidSelectAtIndex:(NSIndexPath *)indexPath {
    CD_NSLog(@"%d",indexPath.row);
    BarViewController1 *bvc1 = [[BarViewController1 alloc] init];
    [self.navigationController pushViewController:bvc1 animated:YES];
}

@end
