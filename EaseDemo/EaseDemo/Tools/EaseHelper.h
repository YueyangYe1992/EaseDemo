//
//  EaseHelper.h
//  EaseDemo
//
//  Created by 叶岳洋 on 16/8/10.
//  Copyright © 2016年 HL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListViewController.h"
#import "UserListViewController.h"
#import "SettingViewController.h"
#import "CustomTabbarViewController.h"
#import "ChatViewController.h"

@interface EaseHelper : NSObject <EMChatManagerDelegate,EMContactManagerDelegate,EMClientDelegate>
@property (nonatomic,weak) ConversationListViewController *conversationVC;
@property (nonatomic,weak) UserListViewController *userListVC;
@property (nonatomic,weak) SettingViewController *settingVC;
@property (nonatomic,weak) CustomTabbarViewController *tabbarVC;
@property (nonatomic,weak) ChatViewController *chatVC;
+(instancetype)shareHelper;
@end
