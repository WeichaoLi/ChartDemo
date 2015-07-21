//
//  CDBar.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDBar : UIControl

/**
 *  是0~1之间的值，可以认为是高度比例
 */
@property (nonatomic, assign) float         grade;
@property (nonatomic, strong) UIColor       *barColor;
@property (nonatomic, strong) NSIndexPath   *indexPath;

@property (nonatomic, assign) BOOL      canTouch;
@property (nonatomic, assign) BOOL      canMove;

//@property (nonatomic, strong) UIColor   *selectColor;

- (void)highlightWithColor:(UIColor *)color;
- (void)recover;

@end
