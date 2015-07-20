//
//  LWCTableViewController.m
//  TableView
//
//  Created by 李伟超 on 14-9-15.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "CommonListViewController.h"

@interface CommonListViewController ()

@end

@implementation CommonListViewController

- (void)loadView {
    [super loadView];
    
    [self createUI];
}

- (void)createUI {
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma mark - CommonTableViewDataSource

- (Class)CellClass {
    return [UITableViewCell class];
}

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object {
    return nil;
}


- (UITableViewCell *)dequeueReusableCellWithTableView:(UITableView *)tableView {
    Class cellClass = [self CellClass];
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
//        NSLog(@"===reuse");
    }
    return cell;
}

#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//    // Return the number of sections.
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self dequeueReusableCellWithTableView:tableView];
    
    [self tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    
    return cell;
}

@end
