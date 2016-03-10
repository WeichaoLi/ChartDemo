//
//  MyNavigationController.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "MyNavigationController.h"

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.navigationBar.translucent = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;        
    }
#endif
    
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.028 alpha:1.000]];
}

- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


- (NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

@end
