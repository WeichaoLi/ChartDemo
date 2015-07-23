//
//  CDBarChart.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CDBarChart.h"
#import "CDBar.h"
#import "CDLabel.h"
#import "PopoverView.h"
#import "CDScrollView.h"

@interface CDBarChart () {
    CDScrollView *myScrollView;
    
    CGFloat _xLabelWidth;
    float _yValueMax;
    float _yValueMin;
    
}

@property (strong, nonatomic) NSMutableSet *yLables;
@property (strong, nonatomic) NSMutableSet *barSet;
@property (strong, nonatomic) CDBar        *selectBar;

@end

@implementation CDBarChart {

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        myScrollView = [[CDScrollView alloc] initWithFrame:CGRectMake(CDYLabelwidth, 0, frame.size.width - CDYLabelwidth, frame.size.height)];
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.bounces = NO;
        myScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        myScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:myScrollView];
        
        _showRange = YES;
        _showYCoordinate = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithType:(DidSelectType)type {
    self = [self initWithFrame:frame];
    self.didSelectType = type;
    return self;
}

- (void)dealloc {
    _dataSource = nil;
    _delegate = nil;
    _selectBar = nil;
    self.yLables = nil;
    [self.barSet makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.barSet = nil;
}

#pragma mark - Getter

- (NSMutableSet *)barSet {
    if (!_barSet) {
        _barSet = [NSMutableSet set];
    }
    return _barSet;
}

- (NSMutableSet *)yLables {
    if (!_yLables) {
        _yLables = [NSMutableSet set];
    }
    return _yLables;
}

#pragma mark - Setter

- (void)setDataSource:(id<ChartBarDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self reloadData];
}

#pragma mark - create UI

/**
 *  Y轴
 */
- (void)setupYCoordinateWith:(NSArray *)yLabels {
    float max = 0;
    float min = 100000000;
    for (NSArray *array in yLabels) {
        /**
         *  最大、最小值
         */
        max = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
        min = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    }
    
    NSUInteger _verticalCount = [_dataSource countInYCoordinate];
    
//    max = (max < _verticalCount) ? _verticalCount : max;
    
    if (self.showRange) {
        _yValueMin = (int)min;
    }else {
        _yValueMin = 0;
    }
    _yValueMax = (int)max;
    
    CGRange _chooseRange = CGRangeZero;
    if (_dataSource && [_dataSource respondsToSelector:@selector(rangeWithYCoordinateValue)]) {
        _chooseRange = [_dataSource rangeWithYCoordinateValue];
    }
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    
    if (_showYCoordinate) {
        float level = (_yValueMax - _yValueMin)/(_verticalCount -1);
        CGFloat chartCavanHeight = self.frame.size.height - CDLabelHeight*3;
        CGFloat levelHeight = chartCavanHeight /(_verticalCount -1);
        for (int i = 0; i < _verticalCount; i++) {
            CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(0.0, chartCavanHeight - i*levelHeight + CDLabelHeight/2, CDYLabelwidth, CDLabelHeight)];
            label.text = [NSString stringWithFormat:@"%.1f", level*i + _yValueMin];
            [self addSubview:label];
            
            [self.yLables addObject:label];
        }
    }else {
        CGRect frame = myScrollView.frame;
        frame.origin.x = 0;
        frame.size.width = CGRectGetWidth(self.frame);
        myScrollView.frame = frame;
    }
}

/**
 *  X轴
 */
- (void)setupXCoordinateLabels:(NSArray *)xLabels WithSectionNumber:(NSInteger)number {
    if (_dataSource && [_dataSource respondsToSelector:@selector(barWidth)]) {
        CGFloat barWidth = [_dataSource barWidth];
        _xLabelWidth = barWidth * number + CDSectionBarMargin + (number - 1) * CDNeerBarMargin;
    }else {
        NSInteger num;
        if (xLabels.count >= 7) {
            num = 7;
        }else if (xLabels.count <= 4) {
            num = 4;
        }else {
            num = xLabels.count;
        }
        _xLabelWidth = CGRectGetWidth(myScrollView.frame)/num;
    }
    
    [xLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CDLabel *label = [[CDLabel alloc] initWithFrame:CGRectMake(idx*_xLabelWidth, CGRectGetHeight(myScrollView.frame) - CDLabelHeight , _xLabelWidth, CDLabelHeight)];
        label.text = obj;
        [myScrollView addSubview:label];
    }];
    
    float maxX = xLabels.count*_xLabelWidth;
    if (CGRectGetWidth(myScrollView.frame) < maxX ) {
        [myScrollView setContentSize:CGSizeMake(maxX + CDNeerBarMargin, CGRectGetHeight(myScrollView.frame))];
    }
}

- (void)strokeChart {
    CGFloat chartCavanHeight = self.frame.size.height - CDLabelHeight*3;
    
    NSArray *_yValues = [_dataSource barYValues];
    [self setupYCoordinateWith:_yValues];
    [self setupXCoordinateLabels:[_dataSource arrayWithXCoordinateValue] WithSectionNumber:_yValues.count];

    NSArray *_colors = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(barColorsInChart)]) {
        _colors = [_dataSource barColorsInChart];
    }else {
        _colors = @[CDGreen, CDRed, CDStarYellow, CDPinkDark];
    }
    
    for (int i=0; i < _yValues.count; i++) {
        NSArray *child = _yValues[i];
        [child enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            float value = [obj floatValue];
            CDBar *bar = [[CDBar alloc] initWithFrame:CGRectMake((idx+(_yValues.count==1?0.1:0.05))*_xLabelWidth +i*_xLabelWidth * 0.47, CDLabelHeight, _xLabelWidth * (_yValues.count==1?0.8:0.45), chartCavanHeight)];
            
            if (_dataSource && [_dataSource respondsToSelector:@selector(barWidth)]) {
                CGFloat barWidth = [_dataSource barWidth];
                CGFloat originX = CDSectionBarMargin / 2 + idx * _xLabelWidth + i*(barWidth + CDNeerBarMargin);
                bar.frame = CGRectMake(originX, CDLabelHeight, barWidth, chartCavanHeight);
            }            
            
            bar.barColor = [_colors objectAtIndex:i];
            bar.grade = (value - _yValueMin) / (_yValueMax - _yValueMin);
            if (value == _yValueMin && value > 0) {
                bar.grade = 0.01;
            }
            bar.indexPath = [NSIndexPath indexPathForItem:idx inSection:i];
            if (_didSelectType == 0) {
                bar.canTouch = YES;
                bar.canMove = NO;
            }else {
                bar.canTouch = NO;
                bar.canMove = YES;
            }
            
            /**
             *  点击事件
             */
            [bar addTarget:self action:@selector(clickBar:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.barSet addObject:bar];
            
            [myScrollView addSubview:bar];
        }];
    }
}

#pragma mark - public Method

- (void)reloadData {
    [myScrollView setContentOffset:CGPointZero];
//    [self.barSet makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.yLables makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.yLables = nil;
    self.barSet = nil;
    
    [self strokeChart];
}

#pragma mark - touch

- (void)clickBar:(CDBar *)bar {
    self.selectBar = bar;
    if (_delegate && [_delegate respondsToSelector:@selector(chartBarDidSelectAtIndex:)]) {
        [_delegate chartBarDidSelectAtIndex:bar.indexPath];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.barSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        CDBar *bar = (CDBar *)obj;
        CGPoint point = [[touches anyObject] locationInView:bar];
        if ([bar.layer containsPoint:point]) {
            if (_delegate && bar.canMove && [_delegate respondsToSelector:@selector(barColorMoveToIndex:AtPoint:)]) {
                [self.selectBar recover];
                self.selectBar = bar;
                UIColor *color = [_delegate barColorMoveToIndex:bar.indexPath AtPoint:[[touches anyObject] locationInView:self]];
                if (color) {
                    [bar highlightWithColor:color];
                }
            }
            return;
        }
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.barSet enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        CDBar *bar = (CDBar *)obj;
        CGPoint point = [[touches anyObject] locationInView:bar];
        if ([bar.layer containsPoint:point]) {
            if (_delegate && bar.canMove && [_delegate respondsToSelector:@selector(barColorMoveToIndex:AtPoint:)]) {
                [self.selectBar recover];
                self.selectBar = bar;
                UIColor *color = [_delegate barColorMoveToIndex:bar.indexPath AtPoint:[[touches anyObject] locationInView:self]];
                if (color) {
                    [bar highlightWithColor:color];
                }
            }
            return;
        }
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_didSelectType == DidSelectTypeMove && _delegate && [_delegate respondsToSelector:@selector(restoreBarWhenEndMove)]) {
        if ([_delegate restoreBarWhenEndMove]) {
            /**
             *  还原
             */
            [self.selectBar recover];
            self.selectBar = nil;
        };
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_didSelectType == DidSelectTypeMove && _delegate && [_delegate respondsToSelector:@selector(restoreBarWhenEndMove)]) {
        if ([_delegate restoreBarWhenEndMove]) {
            /**
             *  还原
             */
            [self.selectBar recover];
            self.selectBar = nil;
        };
    }
}

@end
