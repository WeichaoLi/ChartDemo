//
//  CDCakeChart.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/22.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChartCakeDataSource, ChartCakeDeledate;

@interface CDCakeChart : UIView

@property (nonatomic, assign) id<ChartCakeDataSource>   dataSource;
@property (nonatomic, assign) id<ChartCakeDeledate>     delegate;


- (void)reloadData;

@end

@protocol ChartCakeDataSource <NSObject>

- (NSArray *)proportionsInEveryArc;

- (NSArray *)colorsInEachOfArc;

@optional

/**
 *  起点弧度, 0 ~ 2*PI
 */
- (CGFloat)startAngleInCircle;

@end

@protocol ChartCakeDeledate <NSObject>

@optional

- (void)didSelectAtIndex:(NSInteger)index;

@end
