//
//  MenuTableViewController.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/28/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "MenuTableViewController.h"
#import "TableViewControllerDemo.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.dataSource addObject:@"UIRefreshControl in UITableViewController"];
    [self.dataSource addObject:@"UIRefreshControl in UIViewController + UITableView"];
    [self.dataSource addObject:@"UIRefreshControl in UIViewController + UIScrollView"];
    [self.dataSource addObject:@"UserHome Demo"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = nil;
    if (indexPath.row == 0) {
        reuseIdentifier = @"MenuCellTableVC";
    } else if (indexPath.row == 1) {
        reuseIdentifier = @"MenuCellTableView";
    } else if (indexPath.row == 2) {
        reuseIdentifier = @"MenuCellScrollView";
    } else {
        reuseIdentifier = @"UserHomeDemo";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    segue.destinationViewController.title = [self.dataSource objectAtIndex:[self.tableView indexPathForCell:sender].row];
}


@end
