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

@end

@protocol ChartCakeDataSource <NSObject>



@optional

@end

@protocol ChartCakeDeledate <NSObject>

@optional

- (void)didSelectAtIndex:(NSInteger)index;

@end
