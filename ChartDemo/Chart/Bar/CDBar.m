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
    if (grade <= 0)
        return;
    
    _grade = grade;
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(0, self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(0, (1 - grade) * self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), (1 - grade) * self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [progressline closePath];
    
    _chartLine.frame = self.bounds;
    _chartLine.path = progressline.CGPath;
    _chartLine.fillMode = kCAFillModeForwards;
    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.lineWidth = 1.0;
    _chartLine.fillColor = [self.barColor CGColor];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    pathAnimation.duration = 0.6;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0)];
    pathAnimation.toValue = [NSValue valueWithCGRect:self.bounds];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"bounds"];
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
//        CGPoint point = [[touches anyObject] locationInView:self];
//        if (CGPathContainsPoint(_chartLine.path, NULL, point, NO)) {
//        }
        [super touchesBegan:touches withEvent:event];
        [self highlightWithColor:[UIColor blueColor]];
    }
    if (_canMove) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (_canMove) {
        [self.nextResponder touchesMoved:touches withEvent:event];
//    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canTouch && _originColor) {
        if (_grade > 0) {
            [super touchesEnded:touches withEvent:event];
        }        
        [self recover];
    }
    if (_canMove) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_canTouch && _originColor) {
        [super touchesCancelled:touches withEvent:event];
        [self recover];
    }    
    if (_canMove) {
        [self.nextResponder touchesCancelled:touches withEvent:event];
    }
}

@end
