//
//  BarViewController1.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/17.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "BarViewController1.h"
#import "CDBarChart.h"

@interface BarViewController1 ()<ChartBarDelegate, ChartBarDataSource>

@end

@implementation BarViewController1 {
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
    
    
    CDBarChart *barChart = [[CDBarChart alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 200) WithType:DidSelectTypeMove];
    barChart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
//    barChart.showYCoordinate = NO;
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
    return @[@"10/5", @"10/6", @"10/7", @"10/8", @"10/9", @"10/10", @"10/11", @"10/12", @"10/13", @"10/14", @"10/15"];
}

- (CGRange)rangeWithYCoordinateValue {
    return CGRangeMake(20, 10);
}

- (NSArray *)barYValues {
    NSArray *yValue1 = @[@"13", @"10", @"15", @"19", @"12", @"14", @"13", @"16", @"15", @"12", @"19"];
    return @[yValue1, yValue1];
}

- (NSUInteger)countInYCoordinate {
    return 6;
}

- (CGFloat)barWidth {
    return 30.f;
}

- (NSArray *)barColorsInChart {
    return @[CDGreen, CDLightBlue];
}

#pragma mark - ChartBarDelegate

- (UIColor *)barColorMoveToIndex:(NSIndexPath *)indexPath AtPoint:(CGPoint)Point {
//    CD_NSLog(@"%@, %@",indexPath, NSStringFromCGPoint(Point));
    label.text = [NSString stringWithFormat:@"第 %d 个", indexPath.row];
    return [UIColor redColor];
}

- (BOOL)restoreBarWhenEndMove {
//    CD_NSLog(@"END");
    return NO;
}

@end
