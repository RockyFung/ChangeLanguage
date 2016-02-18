//
//  ViewController.m
//  程序内部多语言切换
//
//  Created by rocky on 16/2/18.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "LocalViewController.h"


#import "ACLanguageUtil.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 200, 50);
    [btn setTitle:NSLocalizedString(@"go to",nil) forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
    
    // 添加通知，改变语言
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLanguageChangedNotification:)
                                                 name:ACLanguageUtilLanguageIdentifier
                                               object:nil];
    
}


// 接收到通知执行的方法
- (void) receiveLanguageChangedNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:ACLanguageUtilLanguageIdentifier])
    {
        [self.btn setTitle:NSLocalizedString(@"go to",nil) forState:UIControlStateNormal];
    }
}


// 跳转到第二个页面
- (void)action{
    LocalViewController *vc = [[LocalViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


// 消除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ACLanguageUtilLanguageIdentifier object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
