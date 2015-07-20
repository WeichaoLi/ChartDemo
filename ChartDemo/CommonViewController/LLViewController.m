//
//  ViewController.m
//  Download_Demo
//
//  Created by 李伟超 on 15/3/18.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "LLViewController.h"

@interface LLViewController ()

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    UIView *footerView = [[UIView alloc] init];
    [_myTableView setTableFooterView:footerView];
    
//    _dataArray = [NSMutableArray arrayWithObjects:
//                  @"http协议",
//                  @"",
//                  @"",
//                  @"",
//                  @"",
//                  nil];
//    
//    _viewControllerArray = [NSMutableArray arrayWithObjects:
//                            @"HttpViewController",
//                            @"",
//                            @"",
//                            @"",
//                            @"",
//                            nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
//    static BOOL nibRegister = NO;
//    if (!nibRegister) {
//        UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
//        [tableView registerNib:nib forCellReuseIdentifier:identifier];
//        nibRegister = YES;
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)transmitValueWhenPushWith:(BasicViewController *)viewController AtIndex:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ViewControllerClass = _viewControllerArray[indexPath.row];
    if (ViewControllerClass.length) {
        
        BasicViewController *viewController = [[NSClassFromString(ViewControllerClass) alloc] init];
        [self transmitValueWhenPushWith:viewController AtIndex:indexPath];
        viewController.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:200.0/250 green:200.0/250 blue:200.0/250 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

@end

