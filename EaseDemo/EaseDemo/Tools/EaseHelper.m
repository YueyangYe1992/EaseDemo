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
    [EMClient sharedClient].chatManager removeDelegate:self];
}


@end
