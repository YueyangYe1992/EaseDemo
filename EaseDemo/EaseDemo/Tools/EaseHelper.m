//
//  EaseHelper.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/8/10.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "EaseHelper.h"

static EaseHelper *helper = nil;

@implementation EaseHelper
+(instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[EaseHelper alloc] init];
    });
    return helper;
}

-(id) init{
    self = [super init];
    if (self) {
        [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
        [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    }
    return self;
}



-(void)dealloc{
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

#pragma mark --- ChatManagerDelegate
-(void)didUpdateConversationList:(NSArray *)aConversationList{
    if (self.tabbarVC) {
        [self.tabbarVC setupUnreadMessageCount];
    }
    if (self.conversationVC) {
        [self.conversationVC tableViewDidTriggerHeaderRefresh];
    }
}

-(void) didReceiveMessages:(NSArray *)aMessages{
    BOOL isRefreshCons = YES;
    for(EMMessage *message in aMessages){
        BOOL needShowNotification = (message.chatType != EMChatTypeChat) ? [self _needShowNotification:message.conversationId] : YES;
        if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            switch (state) {
                case UIApplicationStateActive:
                    [self.mainVC playSoundAndVibration];
                    break;
                case UIApplicationStateInactive:
                    [self.mainVC playSoundAndVibration];
                    break;
                case UIApplicationStateBackground:
                    [self.mainVC showNotificationWithMessage:message];
                    break;
                default:
                    break;
            }
#endif
        }
        
        if (_chatVC == nil) {
            _chatVC = [self _getCurrentChatView];
        }
        BOOL isChatting = NO;
        if (_chatVC) {
            isChatting = [message.conversationId isEqualToString:_chatVC.conversation.conversationId];
        }
        if (_chatVC == nil || !isChatting) {
            if (self.conversationVC) {
                [_conversationVC refreshAndSortView];
            }
            
            if (_tabbarVC) {
                [_tabbarVC setupUnreadMessageCount];
            }
            return;
        }
        
        if (isChatting) {
            isRefreshCons = NO;
        }
    }
    
    if (isRefreshCons) {
        if (self.conversationVC) {
            [_conversationVC refreshAndSortView];
        }
        
        if (self.tabbarVC) {
            [self.tabbarVC setupUnreadMessageCount];
        }
    }
}

    
    
#pragma mark - private
- (BOOL)_needShowNotification:(NSString *)fromChatter{
        BOOL ret = YES;
        NSArray *igGroupIds = [[EMClient sharedClient].groupManager getAllIgnoredGroupIds];
        //检测消息来源是否被用户屏蔽
        for (NSString *str in igGroupIds) {
            if ([str isEqualToString:fromChatter]) {
                ret = NO;
                break;
            }
        }
        return ret;
    }

- (ChatViewController*)_getCurrentChatView
{
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.tabbarVC.navigationController.viewControllers];
    ChatViewController *chatViewContrller = nil;
    for (id viewController in viewControllers)
    {
        if ([viewController isKindOfClass:[ChatViewController class]])
        {
            chatViewContrller = viewController;
            break;
        }
    }
    return chatViewContrller;
}


@end
