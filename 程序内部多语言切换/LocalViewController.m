//
//  LocalViewController.m
//  程序内部多语言切换
//
//  Created by rocky on 16/2/18.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "LocalViewController.h"
#import "ACLanguageUtil.h"
#import "AppDelegate.h"
@interface LocalViewController ()
@property (nonatomic, strong) UILabel *testStr;
@property (nonatomic, retain) NSString *switchToLanguageCodeString; 
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;
@end

@implementation LocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.testStr = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
    self.testStr.backgroundColor = [UIColor grayColor];
    self.testStr.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.testStr];
    self.testStr.text = NSLocalizedString(@"str",nil);
//    [self configureViewFromLocalisation];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 200, 200, 50);
    [btn setTitle:NSLocalizedString(@"back", nil)  forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 300, 200, 50);
    [btn2 setTitle:NSLocalizedString(@"change", nil) forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:20];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    
}

// 中英文切换
- (void)change{

    self.switchToLanguageCodeString = nil;
    // 中英文切换
    if ([[ACLanguageUtil sharedInstance].currentLanguage isEqualToString: @"en" ]) {
        self.switchToLanguageCodeString = @"zh-Hans";
    }else if ([[ACLanguageUtil sharedInstance].currentLanguage isEqualToString: @"zh-Hans" ]){
        self.switchToLanguageCodeString = @"en";
    }
    
    // 让appDelegate设置语言
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate reDrawAllUIForLanguage:self.switchToLanguageCodeString];
    [self configureViewFromLocalisation];
    
    // 发送通知，让其他页面改变语言
    [[NSNotificationCenter defaultCenter] postNotificationName:ACLanguageUtilLanguageIdentifier object:nil];
}


// 重新设置文字
-(void)configureViewFromLocalisation
{
    self.testStr.text = NSLocalizedString(@"str",nil);
    [self.btn setTitle:NSLocalizedString(@"back", nil)  forState:UIControlStateNormal];
    [self.btn2 setTitle:NSLocalizedString(@"change", nil) forState:UIControlStateNormal];
}

// 返回按钮
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
