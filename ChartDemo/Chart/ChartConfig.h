//
//  chartConfig.h
//  ChartDemo
//
//  Created by 李伟超 on 15/7/16.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#ifndef ChartDemo_chartConfig_h
#define ChartDemo_chartConfig_h

#ifdef DEBUG
#define CD_NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CD_NSLog(format, ...)
#endif

#define CD_ColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define CD_ColorForRGB(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]


/**
 *  颜色值
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define CDGrey         [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0f]
#define CDLightBlue    [UIColor colorWithRed:94.0/255.0 green:147.0/255.0 blue:196.0/255.0 alpha:1.0f]
#define CDGreen        [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define CDTitleColor   [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:113.0/255.0 alpha:1.0f]
#define CDButtonGrey   [UIColor colorWithRed:141.0/255.0 green:141.0/255.0 blue:141.0/255.0 alpha:1.0f]
#define CDFreshGreen   [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define CDRed          [UIColor colorWithRed:245.0/255.0 green:94.0/255.0 blue:78.0/255.0 alpha:1.0f]
#define CDMauve        [UIColor colorWithRed:88.0/255.0 green:75.0/255.0 blue:103.0/255.0 alpha:1.0f]
#define CDBrown        [UIColor colorWithRed:119.0/255.0 green:107.0/255.0 blue:95.0/255.0 alpha:1.0f]
#define CDBlue         [UIColor colorWithRed:82.0/255.0 green:116.0/255.0 blue:188.0/255.0 alpha:1.0f]
#define CDDarkBlue     [UIColor colorWithRed:121.0/255.0 green:134.0/255.0 blue:142.0/255.0 alpha:1.0f]
#define CDYellow       [UIColor colorWithRed:242.0/255.0 green:197.0/255.0 blue:117.0/255.0 alpha:1.0f]
#define CDWhite        [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f]
#define CDDeepGrey     [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1.0f]
#define CDPinkGrey     [UIColor colorWithRed:200.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0f]
#define CDHealYellow   [UIColor colorWithRed:245.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0f]
#define CDLightGrey    [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0f]
#define CDCleanGrey    [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0f]
#define CDLightYellow  [UIColor colorWithRed:241.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0f]
#define CDDarkYellow   [UIColor colorWithRed:152.0/255.0 green:150.0/255.0 blue:159.0/255.0 alpha:1.0f]
#define CDPinkDark     [UIColor colorWithRed:170.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0f]
#define CDCloudWhite   [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0f]
#define CDBlack        [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0f]
#define CDStarYellow   [UIColor colorWithRed:252.0/255.0 green:223.0/255.0 blue:101.0/255.0 alpha:1.0f]
#define CDTwitterColor [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:243.0/255.0 alpha:1.0]
#define CDWeiboColor   [UIColor colorWithRed:250.0/255.0 green:0.0/255.0 blue:33.0/255.0 alpha:1.0]
#define CDiOSGreenColor [UIColor colorWithRed:98.0/255.0 green:247.0/255.0 blue:77.0/255.0 alpha:1.0]
#define CDRandomColor   [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]



#endif

//范围
struct Range {
    CGFloat max;
    CGFloat min;
};
typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange
CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0,0};
