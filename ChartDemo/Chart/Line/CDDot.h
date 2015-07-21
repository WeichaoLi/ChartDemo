//
//  CDDot.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/21.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DOTType) {
    DOTTypeSolidCircle = 0,
    DOTTypeHollowCircle,
    DOTTypeRectangle,
};

@interface CDDot : UIControl

@property (nonatomic, assign) DOTType dotType;
@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, assign) CGFloat dotRadius;

@property (nonatomic, strong) NSIndexPath   *indexPath;

- (id)initWithFrame:(CGRect)frame DotColor:(UIColor *)dotColor;

@end
