//
//  CDBar.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CDBar.h"
#import "ChartConfig.h"

@interface CDBar ()

@property (nonatomic, strong) CAShapeLayer  *chartLine;
@property (nonatomic, strong) UIColor *originColor;

@end

@implementation CDBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapSquare;
        _chartLine.fillColor   = [[UIColor clearColor] CGColor];
        _chartLine.lineWidth   = self.frame.size.width;
        _chartLine.strokeEnd   = 0.0;
        _canTouch = YES;
        _canMove = NO;
        self.clipsToBounds = YES;
        [self.layer addSublayer:_chartLine];
        self.layer.cornerRadius = 2.0;
    }
    return self;
}

- (void)dealloc {
    _originColor = nil;
    _chartLine = nil;
    _barColor = nil;
    _indexPath = nil;
}

#pragma mark - property

- (UIColor *)barColor {
    if (!_barColor) {
        _barColor = CDBrown;
    }
    return _barColor;
}

-(void)setGrade:(float)grade {
    if (grade==0)
        grade = 2.5/CGRectGetHeight(self.frame);
    
    _grade = grade;
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(0, self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(0, (1 - grade) * self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), (1 - grade) * self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
//    [progressline setLineWidth:1.0];
//    [progressline setLineCapStyle:kCGLineCapRound];
    _chartLine.path = progressline.CGPath;
    _chartLine.fillMode = kCAFillModeForwards;
    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.lineWidth = 1.0;
//    _chartLine.fillColor = [UIColor clearColor].CGColor;
    _chartLine.fillColor = [self.barColor CGColor];
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"frame.height"];
//    pathAnimation.duration = 1.5;
//    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    pathAnimation.autoreverses = NO;
//    [_chartLine addAnimation:pathAnimation forKey:@"height"];

    _chartLine.strokeEnd = 2.0;
}

#pragma mark - public Method

- (void)highlightWithColor:(UIColor *)color {
    _originColor = [UIColor colorWithCGColor:_chartLine.fillColor];
    _chartLine.fillColor = color.CGColor;
}

- (void)recover {
    _chartLine.fillColor = _originColor.CGColor;
    _originColor = nil;
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canTouch) {
        CGPoint point = [[touches anyObject] locationInView:self];
        if (CGPathContainsPoint(_chartLine.path, NULL, point, NO)) {            
            
            if (_beginSelect) {
                [self highlightWithColor:_beginSelect(_indexPath, point)];
            }
        }
    }
    if (_canMove) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canMove) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canTouch && _originColor) {
        if (_didSelect) {
            _didSelect(_indexPath);
        }
        [self recover];
    }
    if (_canMove) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canTouch && _originColor) {
        [self recover];
    }
    if (_canMove) {
        [self.nextResponder touchesCancelled:touches withEvent:event];
    }
}

@end
