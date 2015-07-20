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

@interface BarViewController ()<ChartBarDelegate, ChartBarDataSource>

@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CDBarChart *barChart = [[CDBarChart alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200) WithType:DidSelectTypeTouch];
    barChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    barChart.didSelectType = DidSelectTypeTouch;
    barChart.delegate = self;
    barChart.dataSource = self;
    
    
    [self.view addSubview:barChart];    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - ChartBarDataSource

- (NSArray *)arrayWithXCoordinateValue {
    return @[@"10/5", @"10/6", @"10/7", @"10/8", @"10/9", @"10/10", @"10/11", @"10/12"];
}

- (CGRange)rangeWithYCoordinateValue {
    return CGRangeMake(20, 10);
}

- (NSArray *)barYValues {
    NSArray *yValue1 = @[@"13", @"10", @"15", @"19", @"12", @"14", @"13", @"16"];
    return @[yValue1];
}

- (NSUInteger)countInYCoordinate {
    return 6;
}

- (NSArray *)barColorsInChart {
    return @[CDRed];
}

#pragma mark - ChartBarDelegate

- (void)chartBarDidSelectAtIndex:(NSIndexPath *)indexPath {
//    CD_NSLog(@"%@", indexPath);
}

- (void)popViewAtIndex:(NSIndexPath *)indexPath {
    CD_NSLog(@"%d",indexPath.row);
    BarViewController1 *bvc1 = [[BarViewController1 alloc] init];
    [self.navigationController pushViewController:bvc1 animated:YES];
}

@end
