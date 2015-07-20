//
//  CDBar.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIColor*(^BeginSelect)(NSIndexPath *indexPath, CGPoint point);
typedef void(^DidSelect)(NSIndexPath *indexPath);

@interface CDBar : UIControl

/**
 *  是0~1之间的值，可以认为是高度比例
 */
@property (nonatomic, assign) float         grade;
@property (nonatomic, strong) UIColor       *barColor;
@property (nonatomic, strong) NSIndexPath   *indexPath;

@property (nonatomic, assign) BOOL      canTouch;
@property (nonatomic, assign) BOOL      canMove;
/**
 *  默认可以点击
 */
@property (nonatomic, copy) BeginSelect   beginSelect;
@property (nonatomic, copy) DidSelect   didSelect;


- (void)highlightWithColor:(UIColor *)color;
- (void)recover;

@end
