//
//  LWCTableViewController.h
//  TableView
//
//  Created by 李伟超 on 14-9-15.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "BasicViewController.h"

@protocol CommonTableViewDataSource <UITableViewDataSource>

@required

- (Class)CellClass;

- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell willAppearAtIndexPath:(NSIndexPath*)indexPath;

- (NSIndexPath*)tableView:(UITableView*)tableView indexPathForObject:(id)object;

- (UITableViewCell *)dequeueReusableCellWithTableView:(UITableView *)tableView;

@optional

@end

@interface CommonListViewController : BasicViewController<UITableViewDelegate,CommonTableViewDataSource>

@property (nonatomic, retain) UITableView *tableview;

@property (nonatomic, retain) NSArray *dataArray;

@end
