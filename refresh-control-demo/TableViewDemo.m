//
//  TableViewDemo.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/28/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "TableViewDemo.h"

@interface TableViewDemo () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TableViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
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
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndexCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"TableViewDemo {%@, %@}", @(indexPath.section), @(indexPath.row)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
