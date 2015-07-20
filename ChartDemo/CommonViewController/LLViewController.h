//
//  ViewController.h
//  Download_Demo
//
//  Created by 李伟超 on 15/3/18.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface LLViewController : BasicViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *viewControllerArray;

- (void)transmitValueWhenPushWith:(BasicViewController *)VC AtIndex:(NSIndexPath *)indexPath;

@end

