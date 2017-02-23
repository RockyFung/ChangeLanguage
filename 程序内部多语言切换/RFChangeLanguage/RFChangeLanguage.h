//
//  RFChangeLanguage.h
//  程序内部多语言切换
//
//  Created by rocky on 2017/2/23.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>


// 取消系统的宏定义
#undef NSLocalizedString
// 自定义
#define NSLocalizedString(key, comment) \
[[RFChangeLanguage sharedInstance] localizedStringForKey:(key)]


#undef NSLocalizedStringFromTable
#define NSLocalizedStringFromTable(key, tbl, comment) \
[[RFChangeLanguage sharedInstance] localizedStringForKey:(key) fromTable:(tbl)]

#undef NSLocalizedStringFromTableInBundle
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
[[[RFChangeLanguage sharedInstance] manualLanguageBundle:(bundle)] localizedStringForKey:(key) value:@"" table:(tbl)]

#undef NSLocalizedStringWithDefaultValue
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
[[[RFChangeLanguage sharedInstance] manualLanguageBundle:(bundle)] localizedStringForKey:(key) value:(val) table:(tbl)]


// 通知ID
static NSString * const RFChangeLanguageIdentifier = @"RFChangeLanguageIdentifier";


@interface RFChangeLanguage : NSObject

// 获取单例
+ (RFChangeLanguage *)sharedInstance;

// 获取当前保存语言
- (NSString *)currentSaveLanguage;

// 获取系统默认语言
-(NSString *)systemLanguage;

// 设置语言
- (void)setLanguage:(NSString *)language;




- (NSString *)localizedStringForKey:(NSString *)key;
- (NSString *)localizedStringForKey:(NSString *)key fromTable:(NSString *)table;
- (NSBundle *)manualLanguageBundle:(NSBundle *)bundle;



@end
