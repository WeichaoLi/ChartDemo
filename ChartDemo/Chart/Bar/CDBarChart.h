//
//  CDBarChart.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartConfig.h"


#define CDNeerBarMargin     5.0
#define CDSectionBarMargin  10.0
#define CDLabelHeight       10.0
#define CDYLabelwidth       30.0

@protocol ChartBarDataSource, ChartBarDelegate;

typedef NS_ENUM(NSInteger, DidSelectType){
    DidSelectTypeTouch = 0, //点击触发
    DidSelectTypeMove,      //移动触发
};

@interface CDBarChart : UIView

@property (nonatomic, assign) id<ChartBarDataSource> dataSource;
@property (nonatomic, assign) id<ChartBarDelegate>  delegate;
@property (nonatomic, assign) DidSelectType didSelectType;
@property (nonatomic, assign) BOOL showYCoordinate;
@property (nonatomic, assign) BOOL showRange;

- (instancetype)initWithFrame:(CGRect)frame WithType:(DidSelectType)type;
- (void)reloadData;

@end

@protocol ChartBarDataSource <NSObject>

/**
 *  X轴坐标数组
 */
- (NSArray *)arrayWithXCoordinateValue;

/**
 *  Y轴坐标点个数
 */
- (NSUInteger)countInYCoordinate;

- (NSArray *)barYValues;

@optional

/**
 *  Y轴坐标范围
 */
- (CGRange)rangeWithYCoordinateValue;

/**
 *  bar的颜色
 */
- (NSArray *)barColorsInChart;

/**
 *  bar的宽度
 */
- (CGFloat)barWidth;

@end

@protocol ChartBarDelegate <NSObject>

@optional

/**
 *  点击选中
 */
- (void)chartBarDidSelectAtIndex:(NSIndexPath *)indexPath;
- (void)popViewAtIndex:(NSIndexPath *)indexPath;

/**
 *  滑动选中，返回选中的颜色
 */
- (UIColor *)barColorMoveToIndex:(NSIndexPath *)indexPath AtPoint:(CGPoint)Point;

/**
 *  结束滑动选中后，是否恢复bar的颜色
 */
- (BOOL)restoreBarWhenEndMove;


@end
