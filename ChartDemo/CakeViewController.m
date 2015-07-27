//
//  CakeViewController.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/22.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CakeViewController.h"
#import "ChartConfig.h"
#import "VBPieChart.h"

@interface CakeViewController ()

@property (nonatomic, retain) VBPieChart *chart;

@property (nonatomic, retain) NSArray *chartValues;

@end

@implementation CakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_chart) {
        _chart = [[VBPieChart alloc] init];
        [self.view addSubview:_chart];
    }
    [_chart setFrame:CGRectMake(10, 50, 300, 300)];
    [_chart setEnableStrokeColor:YES];
    
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:0.7];
    
    
    [_chart setHoleRadiusPrecent:0.];
    [_chart setStrokeColor:[UIColor blackColor]];
    [_chart setLabelsPosition:VBLabelsPositionOutChart];
    [_chart setLabelBlock:^(CALayer *layer){
        return CGPointZero;
    }];
    
    self.chartValues = @[
                         @{@"name":@"first", @"value":@1, @"color":CD_ColorHex(0xdd191d)},
                         @{@"name":@"sec", @"value":@2, @"color":CD_ColorHex(0xd81b60)},
                         @{@"name":@"third", @"value":@3, @"color":CD_ColorHex(0x8e24aa)},
                         @{@"name":@"fourth", @"value":@4, @"color":CD_ColorHex(0x3f51b5)},
                         ];
    
//    self.chartValues = @[
//                         @{@"name":@"first", @"value":@50, @"color":CD_ColorHex(0xdd191d)},
//                         @{@"name":@"sec", @"value":@20, @"color":CD_ColorHex(0xd81b60)},
//                         @{@"name":@"third", @"value":@40, @"color":CD_ColorHex(0x8e24aa)},
//                         @{@"name":@"fourth", @"value":@70, @"color":CD_ColorHex(0x3f51b5)},
//                         @{@"name":@"some", @"value":@65, @"color":CD_ColorHex(0x5677fc)},
//                         @{@"name":@"new", @"value":@23, @"color":CD_ColorHex(0x2baf2b)},
//                         @{@"name":@"label", @"value":@34, @"color":CD_ColorHex(0xb0bec5)},
//                         @{@"name":@"here", @"value":@54, @"color":CD_ColorHex(0xf57c00)}
//                         ];
    
    [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowth];
}

@end
