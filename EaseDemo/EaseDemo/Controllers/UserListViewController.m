//
//  UserListViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/7/22.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "UserListViewController.h"
#import "AddFriendViewController.h"
@interface UserListViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation UserListViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    NSArray *friendArr = [[EMClient sharedClient].contactManager getContacts];
    NSLog(@"好友:%ld",friendArr.count);
    
}

-(void)createUI{
    self.title = @"通讯录";
    UIButton *addFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [addFriendBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addFriendBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:addFriendBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    
    [self.view addSubview:self.searchBar];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, _searchBar.frame.size.width, self.view.frame.size.height-self.searchBar.frame.size.height);
    
}

-(void)addFriend{
    AddFriendViewController *addFriendVC = [AddFriendViewController new];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}

#pragma mark -- UITableViewDelegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
