//
//  LineViewController.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/21.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "LineViewController.h"
#import "CDLineChart.h"

@interface LineViewController ()<ChartLineDataSource, ChartLineDelegate>{
    CDLineChart *lineChart;
}

@end

@implementation LineViewController {
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.center = CGPointMake(self.view.center.x, 20);
    label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    lineChart = [[CDLineChart alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 200)];
    lineChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    lineChart.dataSource = self;
    lineChart.delegate   = self;
//    lineChart.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineChart];
}

#pragma mark - ChartLineDataSource

- (NSArray *)LineWithXValues {
    return @[@"10/5", @"10/6", @"10/7", @"10/8", @"10/9", @"10/10", @"10/11", @"10/12", @"10/13", @"10/14", @"10/15"];
}

- (NSUInteger)countInYCoordinate {
    return 6;
}

- (NSArray *)LineYValues {
    NSArray *yValue1 = @[@"13", @"10", @"15", @"19", @"12", @"14", @"13", @"16", @"15", @"12", @"19"];
//    NSArray *yValue2 = @[@"18", @"12", @"13", @"16", @"11", @"17", @"11", @"15", @"19"];
    return @[yValue1];
}

- (CGRange)rangeWithYCoordinateValue {
    return CGRangeMake(20, 10);
}

- (CGFloat)xIntervalWidth {
    return CGRectGetHeight(lineChart.frame)/5;
}

- (NSArray *)LineColorsInChart {
    return @[CDGreen, CDRandomColor];
}

#pragma mark - ChartLineDelegate

- (void)chartLineDidSelectDotAtIndex:(NSIndexPath *)indexPath {
    CD_NSLog(@"%d",indexPath.row);
    label.text = [NSString stringWithFormat:@"第 %d 个", indexPath.row];
}

- (UIColor *)dotColorMoveToIndex:(NSIndexPath *)indexPath AtPoint:(CGPoint)Point {
    label.text = [NSString stringWithFormat:@"第 %d 个", indexPath.row];
    return [UIColor clearColor];
}

- (BOOL)restoreWhenEndMove {
    return YES;
}

@end
