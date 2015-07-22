//
//  CDCakeChart.m
//  ChartDemo
//
//  Created by 李伟超 on 15/7/22.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CDCakeChart.h"

@implementation CDCakeChart {
    CGFloat xCenter;
    CGFloat yCenter;
    CGFloat radius;
    
    CFTimeInterval _duration;
}

/**
 *  从圆弧的起始点开始画线
 *
 *  @param startAngle  起始点的弧度
 *  @param toAngle     终点的弧度
 *  @param clockwise   决定CGPathAddArc是顺时针还是逆时针
 *  @param StrokeColor 线条的颜色
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)drawOneWayAnimationFromAngle:(CGFloat)startAngle ToAngle:(CGFloat)toAngle Clockwise:(bool)clockwise FillColor:(UIColor *)fillColor {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, &transform, xCenter, yCenter, radius, startAngle, toAngle, clockwise);
    layer.path = path;
    CGPathRelease(path);
    layer.fillMode = kCAFillModeForwards;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.lineJoin = kCALineJoinBevel;
    layer.fillColor = fillColor.CGColor;
    layer.zPosition = -10.0;
    
    [self.layer insertSublayer:layer atIndex:0];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = _duration;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    [layer addAnimation:animation forKey:nil];
    
    return layer;
}

/**
 *  从圆弧的中间位置，向两头开始画线
 *
 *  @param startAngle  起始点的弧度
 *  @param toAngle     终点的弧度
 *  @param clockwise   决定CGPathAddArc是顺时针还是逆时针
 *  @param StrokeColor 线条的颜色
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)drawBothWayAnimationFromAngle:(CGFloat)startAngle ToAngle:(CGFloat)toAngle Clockwise:(bool)clockwise FillColor:(UIColor *)fillColor {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, &transform, xCenter, yCenter, radius, startAngle, toAngle, clockwise);
    layer.path = path;
    CGPathRelease(path);
    layer.fillMode = kCAFillModeForwards;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.lineJoin = kCALineJoinBevel;
    layer.fillColor = fillColor.CGColor;
    
    [self.layer insertSublayer:layer atIndex:0];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = _duration;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.duration = _duration;
    animation1.fromValue = [NSNumber numberWithFloat:1.0];
    animation1.toValue = [NSNumber numberWithFloat:0.0];
    
    CAAnimationGroup *grounpA = [CAAnimationGroup animation];
    grounpA.duration = _duration;
    grounpA.autoreverses = NO;
    grounpA.repeatCount = 1;
    grounpA.animations = @[animation, animation1];
    [layer addAnimation:grounpA forKey:@"animationGroup"];
    
    return layer;
}

@end
