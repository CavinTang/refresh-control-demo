//
//  ScrollViewDemo.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/28/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "ScrollViewDemo.h"

@interface ScrollViewDemo () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ScrollViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableViewController *tableVC = [[UITableViewController alloc] init];
    tableVC.tableView = self.tableView;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    tableVC.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refresh:(UIRefreshControl *)refreshControl
{
    NSLog(@"start refresh");
    [self performSelector:@selector(endRefresh:) withObject:refreshControl afterDelay:2.0f];
}

- (void)endRefresh:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
    NSLog(@"end refresh");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        return screenSize.height;
    } else {
        return 0.1f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
