//
//  SettingViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/7/22.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void) createUI{
    self.title = @"设置";
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark --- UITableViewDelegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr = @[@"自动登录",@"消息推送设置",@"黑名单",@"诊断",@"退群时删除会话",@"iOS离线推送昵称",@"个人信息"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = titleArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == 4) {
        cell.accessoryView = [UISwitch new];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [UIView new];
    UIButton *autoLoginBtn = [UIButton new];
    NSString *userNameStr = [[EMClient sharedClient] currentUsername];
    [autoLoginBtn setTitle:[NSString stringWithFormat:@"退出登录(%@)",userNameStr] forState:UIControlStateNormal];
    [autoLoginBtn addTarget:self action:@selector(Logout) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:autoLoginBtn];
    [autoLoginBtn setBackgroundColor:[UIColor redColor]];
    [autoLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView.mas_left).offset(40);
        make.right.equalTo(footView.mas_right).offset(-40);
        make.top.equalTo(footView.mas_top).offset(30);
        make.height.mas_equalTo(45);
    }];
    return footView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

//退出登录
-(void)Logout{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error){
            [[EMClient sharedClient].options setIsAutoLogin:NO];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
            [appdelegate createRootView];
        });
    });
    
    
    
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
