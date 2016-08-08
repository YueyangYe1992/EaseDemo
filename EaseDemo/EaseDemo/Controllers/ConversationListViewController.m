//
//  ConversationListViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/7/23.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "ConversationListViewController.h"

@interface ConversationListViewController ()<EaseConversationListViewControllerDataSource,EaseConversationListViewControllerDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UISearchController *searchC;
@property (nonatomic,strong) NSMutableArray *dataMutableArr;
@end

@implementation ConversationListViewController

-(NSMutableArray *)dataMutableArr{
    if (!_dataMutableArr) {
        _dataMutableArr = [NSMutableArray array];
    }
    return _dataMutableArr;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //内存中刷新页面
    [self refreshAndSortView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会话";
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    [self tableViewDidTriggerHeaderRefresh];
    [self.view addSubview:self.searchBar];
    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- EaseConversationListViewControllerDelegate





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
