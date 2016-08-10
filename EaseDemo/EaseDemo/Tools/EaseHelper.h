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


@interface EaseHelper : NSObject <EMChatManagerDelegate,EMContactManagerDelegate,EMClientDelegate>
@property (nonatomic,strong) ConversationListViewController *conversationVC;
@property (nonatomic,strong) UserListViewController *userListVC;
@property (nonatomic,strong) SettingViewController *settingVC;

+(instancetype)shareHelper;
@end
