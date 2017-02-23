//
//  RFChangeLanguage.m
//  程序内部多语言切换
//
//  Created by rocky on 2017/2/23.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "RFChangeLanguage.h"

// 软件默认支持语言
static NSString * const DefaultLanguage   = @"en";

// 软件支持的语言
static NSString * const SupportLanguages  = @"en, zh-Hans, ja, zh-Hans-CN";


@implementation RFChangeLanguage




+ (RFChangeLanguage *)sharedInstance{
    static RFChangeLanguage *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RFChangeLanguage alloc] init];
    });
    return _sharedInstance;
}

// 初始化设置
- (id)init {
    self = [super init];
    if (self) {
        NSString *lan = [self currentSaveLanguage];
        [self setLanguage:lan];
    }
    return self;
}


#pragma mark - For Macros

- (NSString *)localizedStringForKey:(NSString *)key {
    return  [[self manualLanguageBundle:[NSBundle mainBundle]] localizedStringForKey:(key) value:@"" table:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key fromTable:(NSString *)table {
    return  [[self manualLanguageBundle:[NSBundle mainBundle]] localizedStringForKey:(key) value:@"" table:table];
}

- (NSBundle *)manualLanguageBundle:(NSBundle *)bundle {
    NSBundle *newBundle = bundle;
    
    NSString *currentLanguageString = [[NSUserDefaults standardUserDefaults] objectForKey:RFChangeLanguageIdentifier];
    
    // path to this languages bundle
    NSString *path = [bundle pathForResource:currentLanguageString ofType:@"lproj" ];
    
    if (path) {
        newBundle = [NSBundle bundleWithPath:path];
    }
    
    return newBundle;
}


// 当前语言
- (NSString *)currentSaveLanguage{
    // 取出保存的语言
    NSString *currentLanguageString =
    [[NSUserDefaults standardUserDefaults] objectForKey:RFChangeLanguageIdentifier];
    
    // 判断是否有保存过的语言
    if (currentLanguageString.length > 0) {
        return currentLanguageString;
    }else{  // 如果没有保存的语言就返回系统语言
        NSString *sysLan = [self systemLanguage];
        
        // 判断系统语言在软件中是否被支持
        if ([self isSupportTheNewLanguage:sysLan]) {
            return sysLan;
        }else{
            //如果系统语言不被软件支持，那么就返回自定义默认语言
            return DefaultLanguage;
        }
    }

}

// 设置语言
- (void)setLanguage:(NSString *)language {
    if ([self isSupportTheNewLanguage:language]) {
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:RFChangeLanguageIdentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 发送通知，让其他页面改变语言
        [[NSNotificationCenter defaultCenter] postNotificationName:RFChangeLanguageIdentifier object:nil];
    }
}


// 获取当前系统默认的语言（简体中文 zh-Hans-CN  日文ja-CN）
-(NSString *)systemLanguage{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [def objectForKey:@"AppleLanguages"];
    NSString *current = [[languages objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return current;
}


// 用来判断语言是否被支持
- (BOOL)isSupportTheNewLanguage:(NSString *)newLanguage {
    NSArray *supportLanguagesArray = [SupportLanguages componentsSeparatedByString:@","];
    for (NSString *language in supportLanguagesArray) {
        NSString *cleanLanguage = [language stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([newLanguage isEqualToString:cleanLanguage]) {
            return YES;
        }
    }
    return NO;
}


@end
