//
//  AppDelegate.h
//  程序内部多语言切换
//
//  Created by rocky on 16/2/18.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)changeAllUILanguage:(NSString *)language;
@end

