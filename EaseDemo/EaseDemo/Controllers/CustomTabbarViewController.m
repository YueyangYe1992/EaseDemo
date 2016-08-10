//
//  CustomTabbarViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/6/20.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import "ConversationListViewController.h"
#import "UserListViewController.h"
#import "SettingViewController.h"
@interface CustomTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation CustomTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI{
    //设置上方导航栏标题颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //对话页
    ConversationListViewController *conversationVC = [[ConversationListViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *naviConversation = [[UINavigationController alloc] initWithRootViewController:conversationVC];
    UITabBarItem *conversationItem = [[UITabBarItem alloc] initWithTitle:@"会话" image:[UIImage imageNamed:@"Conversations"] selectedImage:[UIImage imageNamed:@"Conversations"]];
    naviConversation.tabBarItem = conversationItem;
    naviConversation.navigationBar.barTintColor = [UIColor colorWithRed:63/255.0 green:180/255.0 blue:252/255.0 alpha:1.0];
    [naviConversation.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    //通讯录页面
    UserListViewController *userListVC = [[UserListViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *naviUserList = [[UINavigationController alloc] initWithRootViewController:userListVC];
    UITabBarItem *userListItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    naviUserList.tabBarItem = userListItem;
    naviUserList.navigationBar.barTintColor = [UIColor colorWithRed:63/255.0 green:180/255.0 blue:252/255.0 alpha:1.0];
    [naviUserList.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    
    //设置页面
    SettingViewController *settingVC = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *naviSetting = [[UINavigationController alloc] initWithRootViewController:settingVC];
    UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    naviSetting.tabBarItem = settingItem;
    naviSetting.navigationBar.barTintColor = [UIColor colorWithRed:63/255.0 green:180/255.0 blue:252/255.0 alpha:1.0];
    [naviSetting.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    
    NSArray *array = @[naviConversation,naviUserList,naviSetting];
    self.viewControllers = array;

}


//设置未读消息数
-(void)setupUnreadMessageCount{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger UnReadCount = 0;
    for (EMConversation *conversation in conversations) {
        UnReadCount += conversation.unreadMessagesCount;
    }
    UIViewController *vc = [self.viewControllers objectAtIndex:0];
    if (UnReadCount > 0) {
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",UnReadCount];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
            [UIApplication sharedApplication].applicationIconBadgeNumber = UnReadCount;
        }
    }else{
        vc.tabBarItem.badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
}

//设置未处理申请数
-(void)setupUnApplyCount{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];
}



#pragma mark --- EMChatManagerDelegate
-(void)didUpdateConversationList:(NSArray *)aConversationList{
    [self setupUnreadMessageCount];
    ConversationListViewController *vc = [self.viewControllers objectAtIndex:0];
    [vc tableViewDidTriggerHeaderRefresh];
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
