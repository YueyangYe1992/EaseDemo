//
//  AppDelegate.h
//  EaseDemo
//
//  Created by 叶岳洋 on 16/6/20.
//  Copyright © 2016年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CustomTabbarViewController *tabbarVC;

-(void)createRootView;

@end

