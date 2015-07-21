//
//  ViewController.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                  @"柱状图1",
                  @"柱状图2",
                  @"折现图",
                  @"",
                  @"",
                  nil];

    self.viewControllerArray = [NSMutableArray arrayWithObjects:
                            @"BarViewController",
                            @"BarViewController1",
                            @"LineViewController",
                            @"",
                            @"",
                            nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)transmitValueWhenPushWith:(BasicViewController *)VC AtIndex:(NSIndexPath *)indexPath {

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

@end
