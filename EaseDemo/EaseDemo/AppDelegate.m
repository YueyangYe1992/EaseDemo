//
//  AppDelegate.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/6/20.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
@interface AppDelegate ()<EMContactManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self createRootView];
//    _tabbarVC = [[CustomTabbarViewController alloc] init];
//    self.window.rootViewController = _tabbarVC;
    //注册环信
    [self registerEase];
    //[[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    return YES;
}

-(void)registerEase{
    EMOptions *options = [EMOptions optionsWithAppkey:EaseAppKey];
    options.apnsCertName = apnsName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

-(void)createRootView{
    BOOL isLog = [[NSUserDefaults standardUserDefaults] boolForKey:isLogin];
    if (isLog) {
        _tabbarVC = [[CustomTabbarViewController alloc] init];
        self.window.rootViewController = _tabbarVC;
    }
    else{
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
        self.window.rootViewController = navi;
    }
    [self.window reloadInputViews];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
