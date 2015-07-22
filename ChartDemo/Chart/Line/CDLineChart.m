//
//  CDLineChart.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/21.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CDLineChart.h"
#import "CDLabel.h"
#import "CDDot.h"
#import "CDScrollView.h"

@interface CDLineChart () {
    UIScrollView *myScrollView;
    
    CGFloat _xLabelWidth;
    float _yValueMax;
    float _yValueMin;
}

@property (strong, nonatomic) NSMutableSet  *yLables;
@property (strong, nonatomic) NSMutableSet  *dots;
@property (strong, nonatomic) NSMutableSet  *lines;
@property (strong, nonatomic) CAShapeLayer *tagLine;

@end

@implementation CDLineChart

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        myScrollView = [[CDScrollView alloc] initWithFrame:CGRectMake(CDYLabelwidth, 0, frame.size.width - CDYLabelwidth, frame.size.height)];
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        myScrollView.backgroundColor = [UIColor yellowColor];
        [self addSubview:myScrollView];
        
        _showRange = YES;
        _showYCoordinate = YES;
    }
    return self;
}

#pragma mark - Setter

- (void)setDataSource:(id<ChartLineDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self reloadData];
}

#pragma mark - Getter

- (NSMutableSet *)yLables {
    if (!_yLables) {
        _yLables = [NSMutableSet set];
    }
    return _yLables;
}

- (NSMutableSet *)dots {
    if (!_dots) {
        _dots = [NSMutableSet set];
    }
    return _dots;
}

- (CAShapeLayer *)tagLine {
    if (!_tagLine) {
        _tagLine = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, CDLabelHeight);
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetMaxY(myScrollView.frame) - 2*CDLabelHeight);
        
        _tagLine.path = path;
        CGPathRelease(path);
        
        _tagLine.strokeColor = [UIColor redColor].CGColor;
        _tagLine.lineWidth = 1.0;
        _tagLine.fillColor = [UIColor clearColor].CGColor;
        
        [myScrollView.layer addSublayer:_tagLine];
    }
    return _tagLine;
}

- (NSMutableSet *)lines {
    if (!_lines) {
        _lines = [NSMutableSet set];
    }
    return _lines;
}

#pragma mark - reloadData

- (void)reloadData {
    [self.yLables makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.dots = nil;
    self.lines = nil;
    self.yLables = nil;
    
    [self strokeChart];
}

#pragma mark - create UI

- (void)strokeChart {
    CGFloat chartCavanHeight = self.frame.size.height - CDLabelHeight*3;
    
    NSArray *_yValues = [_dataSource LineYValues];
    /**
     *  注意，先建X轴，再建Y轴，因为建Y轴是要用到某些数据
     */
    [self setupXCoordinateLabels:[_dataSource LineWithXValues]];
    [self setupYCoordinateWith:_yValues];
    
    NSArray *_colors = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(LineColorsInChart)]) {
        _colors = [_dataSource LineColorsInChart];
    }else {
        _colors = @[CDGreen, CDRed, CDStarYellow, CDPinkDark];
    }
    
    /**
     *  画折线
     */
    for (int i=0; i < _yValues.count; i++) {
        NSArray *child = _yValues[i];
        UIColor *color = _colors[i];
        
        CAShapeLayer *chartLine = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef path = CGPathCreateMutable();
        [child enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            float value = [obj floatValue];
            float per = (_yValueMax - value) / (_yValueMax - _yValueMin);
            CGFloat y = CDLabelHeight + per * chartCavanHeight;
            CGFloat x = (0.5 + idx) * _xLabelWidth;
            
            if (idx == 0) {
                CGPathMoveToPoint(path, NULL, x, y);
            }else {
                CGPathAddLineToPoint(path, NULL, x, y);
            }
            
            /**
             *  点
             */
            CDDot *dot = [[CDDot alloc] initWithFrame:CGRectMake(0, 0, 23, 23) DotColor:CDRed];
//            dot.backgroundColor = CD_ColorHex(0xE2C54C);
            dot.center = CGPointMake(x, y);
            dot.dotType = DOTTypeHollowCircle;
            dot.indexPath = [NSIndexPath indexPathForRow:idx inSection:i];
            [dot addTarget:self action:@selector(clickDot:) forControlEvents:UIControlEventTouchUpInside];
            [myScrollView addSubview:dot];
            
            [self.dots addObject:dot];
            
        }];
        chartLine.path = path;
        CGPathRelease(path);
        
        chartLine.lineWidth = 2;
        chartLine.strokeColor = color.CGColor;
        chartLine.fillColor = [UIColor clearColor].CGColor;
        
        [myScrollView.layer insertSublayer:chartLine atIndex:0];
    }
}

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
            
            /**
             *  画横线
             */
            CGFloat y = label.center.y;
//            CGFloat x = _xLabelWidth/2;
//            CGFloat tx = myScrollView.contentSize.width - _xLabelWidth;
            CGFloat x = 0;
            CGFloat tx = myScrollView.contentSize.width;
           
            [myScrollView.layer addSublayer:[self addLineAtOriginPoint:CGPointMake(x, y) ToPoint:CGPointMake(tx, y)]];
        }
    }else {
        CGRect frame = myScrollView.frame;
        frame.origin.x = 0;
        frame.size.width = CGRectGetWidth(self.frame);
        myScrollView.frame = frame;
    }
}

/**
 *  背景线
 */
- (CAShapeLayer *)addLineAtOriginPoint:(CGPoint)point ToPoint:(CGPoint)toPoint {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, toPoint.x, toPoint.y);
    
    layer.path = path;
    CGPathRelease(path);

    layer.strokeColor = CD_ColorForRGB(0, 0, 0, 0.1).CGColor;
    layer.lineWidth = 1.0;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}

/**
 *  X轴
 */
- (void)setupXCoordinateLabels:(NSArray *)xLabels {
    if (_dataSource && [_dataSource respondsToSelector:@selector(xIntervalWidth)]) {
        _xLabelWidth = [_dataSource xIntervalWidth];
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
        
        /**
         *  画竖线
         */
        CGFloat x = label.center.x;
//        CGFloat x = CGRectGetMinX(label.frame);
        CGFloat y = CDLabelHeight;
        CGFloat ty = CGRectGetMaxY(myScrollView.frame) - 2*CDLabelHeight;
        
        [myScrollView.layer addSublayer:[self addLineAtOriginPoint:CGPointMake(x, y) ToPoint:CGPointMake(x, ty)]];
    }];
    
    float maxX = xLabels.count*_xLabelWidth;
    if (CGRectGetWidth(myScrollView.frame) < maxX ) {
        [myScrollView setContentSize:CGSizeMake(maxX + _xLabelWidth/2, CGRectGetHeight(myScrollView.frame))];
    }
}

#pragma mark - touch event

- (void)clickDot:(CDDot *)dot {
    if (_delegate && [_delegate respondsToSelector:@selector(chartLineDidSelectDotAtIndex:)]) {
        [_delegate chartLineDidSelectDotAtIndex:dot.indexPath];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:myScrollView];
    [self.dots enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        CDDot *dot = (CDDot *)obj;
        
        CGRect rect = dot.frame;
        rect.origin.y = CDLabelHeight;
        rect.size.height = CGRectGetMaxY(myScrollView.frame);
        
        if (CGRectContainsPoint(rect, point)) {
            self.tagLine.position = CGPointMake(dot.center.x, 0);
            
            if (_delegate && [_delegate respondsToSelector:@selector(dotColorMoveToIndex:AtPoint:)]) {
                [_delegate dotColorMoveToIndex:dot.indexPath AtPoint:dot.center];
            }
            return ;
        }
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:myScrollView];
    self.tagLine.position = CGPointMake(point.x, 0);
    [self.dots enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        CDDot *dot = (CDDot *)obj;

        CGRect rect = dot.frame;
        rect.origin.y = CDLabelHeight;
        rect.size.height = CGRectGetMaxY(myScrollView.frame);
        
        if (CGRectContainsPoint(rect, point)) {            
            if (_delegate && [_delegate respondsToSelector:@selector(dotColorMoveToIndex:AtPoint:)]) {
                [_delegate dotColorMoveToIndex:dot.indexPath AtPoint:dot.center];
            }
            return ;
        }        
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(restoreWhenEndMove)]) {
        if ([_delegate restoreWhenEndMove]) {
            [self.tagLine removeFromSuperlayer];
            self.tagLine =  nil;
        };
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(restoreWhenEndMove)]) {
        if ([_delegate restoreWhenEndMove]) {
            [self.tagLine removeFromSuperlayer];
            self.tagLine =  nil;
        };
    }
}

@end
