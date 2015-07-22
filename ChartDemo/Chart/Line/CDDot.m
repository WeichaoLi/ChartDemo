//
//  CDDot.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/21.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CDDot.h"

@implementation CDDot {
    CAShapeLayer *dotLayer;
}

- (instancetype)initWithFrame:(CGRect)frame DotColor:(UIColor *)dotColor {
    if (self = [super initWithFrame:frame]) {
        _dotColor = dotColor;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDotType:(DOTType)dotType {
    [dotLayer removeFromSuperlayer];
    dotLayer = nil;
    dotLayer = [[CAShapeLayer alloc] init];
    dotLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    _dotRadius = _dotRadius ? _dotRadius : 4;
    
    switch (dotType) {
        case DOTTypeSolidCircle:
            [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetWidth(self.frame)/2) radius:_dotRadius startAngle:0 endAngle:M_PI*2 clockwise:1];
            [path closePath];
            dotLayer.path = path.CGPath;
            dotLayer.lineWidth = 2.0;
            dotLayer.strokeColor = _dotColor.CGColor;
            dotLayer.fillColor = _dotColor.CGColor;
            break;
            
        case DOTTypeHollowCircle:
            [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetWidth(self.frame)/2) radius:_dotRadius startAngle:0 endAngle:M_PI*2 clockwise:1];
            [path closePath];
            dotLayer.path = path.CGPath;
            dotLayer.lineWidth = 2.0;
            dotLayer.strokeColor = _dotColor.CGColor;
            dotLayer.fillColor = [UIColor whiteColor].CGColor;
            break;
            
        case DOTTypeRectangle: {
            _dotRadius += 2;
            CGFloat x = (CGRectGetWidth(self.frame) - _dotRadius)/2;
            [path moveToPoint:CGPointMake(x, x)];
            [path addLineToPoint:CGPointMake(x+_dotRadius, x)];
            [path addLineToPoint:CGPointMake(x+_dotRadius, x+_dotRadius)];
            [path addLineToPoint:CGPointMake(x, x+_dotRadius)];
            [path closePath];
            dotLayer.path = path.CGPath;
            dotLayer.lineWidth = 2.0;
            dotLayer.strokeColor = _dotColor.CGColor;
            dotLayer.fillColor = _dotColor.CGColor;
        }
            break;
        default:
            self.dotType = DOTTypeSolidCircle;
        break;
    }
    /**
     *  消除锯齿
     */
    dotLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:dotLayer];
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end
