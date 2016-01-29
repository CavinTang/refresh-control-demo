//
//  UserHomeViewController.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/29/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "UserHomeViewController.h"
#import "MJRefresh.h"
#import "UserHomeHeaderView.h"

@interface UserHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL clearData;

@property (nonatomic, strong) UserHomeHeaderView *tableHeaderView;

@property (nonatomic, assign) BOOL isLeave;
@property (nonatomic, weak) UINavigationController *navigationControllerReference;

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSource = [NSMutableArray array];
    
    UITableViewController *tableVC = [[UITableViewController alloc] init];
    tableVC.tableView = self.tableView;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.layer.zPosition = MAXFLOAT;
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    tableVC.refreshControl = refreshControl;
    
    CGRect bounds = refreshControl.bounds;
    bounds.origin.x = -([UIScreen mainScreen].bounds.size.width / 2 - 50);//右移
    refreshControl.bounds = bounds;
    
    [self addLoadMoreFooterView];
    
    self.tableHeaderView = [UserHomeHeaderView viewFromXib];
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationControllerReference = self.navigationController;
    self.isLeave = NO;
    [self updateNavigationBarAlpha];
    
    [self requestData:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.isLeave = YES;
    [self updateNavigationBarAlpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLoadMoreFooterView {
    __weak UserHomeViewController *weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData:nil];
    }];
}

- (void)refreshData:(UIRefreshControl *)refreshControl
{
    self.clearData = YES;
    
    [self requestData:refreshControl];
}

- (void)requestData:(UIRefreshControl *)refreshControl
{
    [self performSelector:@selector(requestDataFinish:) withObject:refreshControl afterDelay:1.0f];
}

- (void)requestDataFinish:(UIRefreshControl *)refreshControl
{
    if (self.clearData) {
        self.clearData = NO;
        [self.dataSource removeAllObjects];
    }
    
    int start = self.dataSource.count, end = self.dataSource.count + 20;
    for (int index = start; index < end; index++) {
        [self.dataSource addObject:@(index)];
    }
    [self.tableView reloadData];
    
    if (refreshControl) {
        [refreshControl endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - navi bar alpha handle

- (void)updateNavigationBarAlpha
{
    if (self.isLeave) {
        return;
    }
    UIEdgeInsets contentInset = self.tableView.contentInset;
    CGPoint contentOffset = self.tableView.contentOffset;
    CGFloat offsetY = contentOffset.y + contentInset.top;
    CGFloat distanceH = self.tableHeaderView.frame.size.height + contentInset.top - 64;
    
    CGFloat alpha = MIN(1.0f, offsetY / distanceH);
    
    [self updateNavigationBarAlpha:alpha];
}

- (void)updateNavigationBarAlpha:(CGFloat)alpha
{
    if (self.presentedViewController) {
        return;
    }
    self.navigationControllerReference.navigationBar.alpha = alpha;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHomeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateNavigationBarAlpha];
    [self.tableHeaderView updateBGScale];
}

@end
