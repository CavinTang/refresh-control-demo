//
//  ScrollViewDemo.m
//  refresh-control-demo
//
//  Created by CavinTang on 1/28/16.
//  Copyright © 2016 Cavin. All rights reserved.
//

#import "ScrollViewDemo.h"

@interface ScrollViewDemo ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.scrollView.contentSize = CGSizeMake(screenSize.width, screenSize.height + 20);
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refreshControl];
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

@end
