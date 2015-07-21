//
//  CDLineChart.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/21.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartConfig.h"

@protocol ChartLineDataSource, ChartLineDelegate;

@interface CDLineChart : UIView

@property (nonatomic, assign) id<ChartLineDataSource> dataSource;
@property (nonatomic, assign) id<ChartLineDelegate>  delegate;
@property (nonatomic, assign) BOOL showYCoordinate;
@property (nonatomic, assign) BOOL showRange;

- (void)reloadData;

@end

@protocol ChartLineDataSource <NSObject>

/**
 *  X轴坐标数组
 */
- (NSArray *)LineWithXValues;

/**
 *  Y轴坐标点个数
 */
- (NSUInteger)countInYCoordinate;

/**
 *  折线上点的y坐标的值
 */
- (NSArray *)LineYValues;

@optional

/**
 *  Y轴坐标范围
 */
- (CGRange)rangeWithYCoordinateValue;

/**
 *  bar的颜色
 */
- (NSArray *)LineColorsInChart;

/**
 *  X轴的间隔
 */
- (CGFloat)xIntervalWidth;

@end

@protocol ChartLineDelegate <NSObject>

@optional

/**
 *  点击选中
 */
- (void)charLineDidSelectDotAtIndex:(NSIndexPath *)indexPath;
- (void)popViewAtIndex:(NSIndexPath *)indexPath;

/**
 *  滑动选中，返回选中的颜色
 */
- (UIColor *)dotColorMoveToIndex:(NSIndexPath *)indexPath AtPoint:(CGPoint)Point;

/**
 *  结束滑动选中后，是否恢复bar的颜色
 */
- (BOOL)restoreWhenEndMove;

@end
