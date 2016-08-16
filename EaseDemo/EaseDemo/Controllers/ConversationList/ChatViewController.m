//
//  ChatViewController.m
//  EaseDemo
//
//  Created by 叶岳洋 on 16/8/15.
//  Copyright © 2016年 HL. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UIAlertViewDelegate, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,EMClientDelegate>
@property (nonatomic,weak) UIMenuItem *CopyMI;
@property (nonatomic,weak) UIMenuItem *DeleteMI;
@property (nonatomic,weak) UIMenuItem *TranspondMI;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
