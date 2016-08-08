//
//  AddFriendViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/7/27.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger selectIndex;
@end

@implementation AddFriendViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = NSLocalizedString(@"friend.inputNameToSearch", @"input to find friends");
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    
    return _textField;
}

//-(UIView *)headerView{
//    if (!_headerView) {
//        NSLog(@"执行");
//            _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
//            _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
//            
//            [_headerView addSubview:_textField];
//    }
//    return _headerView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI{
    self.title = @"添加好友";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //self.tableView.tableHeaderView = self.headerView;
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.tableView.tableFooterView = footerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)searchFriend{
    NSString *userName = [[EMClient sharedClient] currentUsername];
    if (_textField.text.length > 0) {
        if ([_textField.text isEqualToString:userName]) {
            [MBProgressHUD showError:@"不能添加自己为好友" toView:self.view];
            return;
        }else{
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:_textField.text];
            [self.tableView reloadData];
        }
    }
}


#pragma mark --- UITableViewDelegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor colorWithRed:12/255.0 green:101/255.0 blue:122/255.0 alpha:1.0]];
    cell.accessoryView = addBtn;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    NSString *contactName = self.dataArr[indexPath.row];
    if ([self ContactIsExitWithString:contactName]) {
        [MBProgressHUD showError:@"你们已经是好友" toView:self.view];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"打个招呼吧" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alertView show];
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
    _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
    [_headerView addSubview:self.textField];
    return self.headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(BOOL)ContactIsExitWithString:(NSString *)contactName{
    NSArray *contactArr = [[EMClient sharedClient].contactManager getContactsFromDB];
    for (NSString *name in contactArr) {
        if ([contactName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSString *username = [[EMClient sharedClient] currentUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
        EMError *error = [[EMClient sharedClient].contactManager addContact:self.dataArr[self.selectIndex] message:messageStr];
        if (!error) {
            [MBProgressHUD showSuccess:@"请求发送成功" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [MBProgressHUD showError:error.errorDescription toView:self.view];
        }
    }

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
