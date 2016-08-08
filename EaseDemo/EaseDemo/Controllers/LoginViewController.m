//
//  LoginViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/7/23.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "LoginViewController.h"
#import "ConversationListViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameTF.delegate = self;
    self.passwordTF.delegate = self;
    [self createUI];
    //add code ...
}

-(void)createUI{
    [self cancelCover];
    UIImageView *userNameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user@2x.png"]];
    [self.view addSubview:userNameImage];
    [userNameImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.top.equalTo(self.view.mas_top).offset(60);
    }];
    
    self.userNameTF = [[UITextField alloc] init];
    self.userNameTF.placeholder = @"个人账号/手机";
    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImage.mas_right).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.top.equalTo(self.view.mas_top).offset(55);
        make.height.mas_equalTo(35);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImage.mas_left);
        make.right.equalTo(self.userNameTF.mas_right);
        make.height.mas_equalTo(1);
        make.top.equalTo(userNameImage.mas_bottom).offset(5);
    }];
    
    UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"group@2x.png"]];
    [self.view addSubview:passwordImage];
    [passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.top.equalTo(lineView1.mas_bottom).offset(10);
    }];
    
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.placeholder = @"密码";
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImage.mas_right).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.top.equalTo(lineView1.mas_bottom).offset(5);
        make.height.mas_equalTo(35);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImage.mas_left);
        make.right.equalTo(self.userNameTF.mas_right);
        make.height.mas_equalTo(1);
        make.top.equalTo(passwordImage.mas_bottom).offset(5);
    }];
    
    UIButton *registeBtn = [[UIButton alloc] init];
    [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registeBtn setBackgroundColor:[UIColor colorWithRed:92/255.0 green:186/255.0 blue:207/255.0 alpha:1.0]];
    [registeBtn addTarget:self action:@selector(clickRegisteBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeBtn];
    [registeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImage.mas_left);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
        make.top.equalTo(passwordImage.mas_bottom).offset(20);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:12/255.0 green:101/255.0 blue:122/255.0 alpha:1.0]];
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registeBtn.mas_right).offset(10);
        make.height.mas_equalTo(35);
        make.right.equalTo(lineView1.mas_right);
        make.top.equalTo(passwordImage.mas_bottom).offset(20);
    }];
}

//环信注册账号
-(void)clickRegisteBtn{
    if (self.userNameTF.text.length >= 6 && self.passwordTF.text.length >= 6)
        [MBProgressHUD showMessag:@"正在注册环信" toView:self.view];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //子线程注册环信
            EMError *error = [[EMClient sharedClient] registerWithUsername:self.userNameTF.text password:self.passwordTF.text];
            if (!error) {
                EMError *errorLogin = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.passwordTF.text];
                if (!errorLogin) {
                    //设置自动登录
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isLogin];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                }else{
                    [MBProgressHUD showError:@"登录环信失败" toView:self.view];
                }
                
            }
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                if (error == nil) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.labelText = @"环信注册成功";
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hide:YES];
                        AppDelegate *del = [UIApplication sharedApplication].delegate;
                        [del createRootView];
                    });
                }else{
                    [MBProgressHUD showError:error.errorDescription toView:self.view];
                }
            });
        });
    
    }


//环信登录账号
-(void)clickLoginBtn{
    if (self.userNameTF.text.length > 0 && self.passwordTF.text.length > 0) {
        [MBProgressHUD showMessag:@"正在登录环信" toView:self.view];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.passwordTF.text];
            if (!error) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isLogin];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //设置自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
                if (error == nil) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                    hud.labelText = @"登录成功";
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hide:YES];
                        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
                        [appdelegate createRootView];
                    });
                    
                }else{
                    [MBProgressHUD showError:error.errorDescription toView:self.view];
                }
            });
            
        });
    }else{
        [MBProgressHUD showError:@"账号密码不能为空" toView:self.view];
    }
}

//取消遮挡
-(void)cancelCover{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

//保存当前登录用户个人信息
-(void)saveUserdata{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isLogin];
}


#pragma mark --- UITextFieldDelegate




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
