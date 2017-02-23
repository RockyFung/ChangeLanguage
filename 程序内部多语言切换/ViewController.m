//
//  ViewController.m
//  程序内部多语言切换
//
//  Created by rocky on 16/2/18.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "RFChangeLanguage.h"
#import "AppDelegate.h"

static NSString *switchToLanguageCodeString = nil;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 添加通知，改变语言
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLanguageChangedNotification:)
                                                 name:RFChangeLanguageIdentifier
                                               object:nil];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *current = [[RFChangeLanguage sharedInstance] currentSaveLanguage];
    NSLog(@"上次保存语言 %@",current);
    
    NSString *sysLan = [[RFChangeLanguage sharedInstance] systemLanguage];
    NSLog(@"系统默认语言 %@",sysLan);
    
    [self setLabelLanguage];
}
- (void)setLabelLanguage{
    NSString *current = [[RFChangeLanguage sharedInstance] currentSaveLanguage];
    NSString *testStr = NSLocalizedString(@"我是测试字符串", nil); // @""里的中文相当于key
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)",testStr,current];
    self.imageView.image = [UIImage imageNamed:NSLocalizedString(@"imgName", nil)];
}

- (IBAction)changeToChinese:(id)sender {
    switchToLanguageCodeString = @"zh-Hans"; // 简体中文
    [self changeLanguageWithLanguage];
}
- (IBAction)changeToEnglish:(id)sender {
    switchToLanguageCodeString = @"en"; // 英文
    [self changeLanguageWithLanguage];
}
- (IBAction)changeToJapanese:(id)sender {
    switchToLanguageCodeString = @"ja"; // 日文
    [self changeLanguageWithLanguage];
}

- (void)changeLanguageWithLanguage{
    // 让appDelegate设置语言
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate changeAllUILanguage:switchToLanguageCodeString];
    NSLog(@"改变语言为 %@",switchToLanguageCodeString);
}

// 接收到通知执行改变语言
- (void) receiveLanguageChangedNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:RFChangeLanguageIdentifier]){
        // 改变label的语言
        [self setLabelLanguage];
    }
}


// 消除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RFChangeLanguageIdentifier object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
