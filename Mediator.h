//
//  Mediator.h
//  comment
//
//  Created by 陈刚 on 16/12/29.
//  Copyright © 2016年 DAZHONG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MediatorManager : NSObject
/*
    初始化单例
 */
+ (MediatorManager *_Nonnull)sharedInstence;
/**  push有参数跳转界面
 * @param className  要push的界面类名
 * @param dic        界面所需参数字典
 */
-(void)pushViewController:(NSString *_Nonnull)className
 withPropertyValueDic:(NSMutableDictionary *_Nullable)dic animated:(BOOL)animated;
/**  present有参数跳转界面
 * @param className  要present的界面类名
 * @param dic        界面所需参数字典
 */
-(void)presentiewController:(NSString *_Nonnull)className
    withPropertyValueDic:(NSMutableDictionary *_Nullable)dic animated:(BOOL)animated;
/**
 * @return UIViewController  当前根控制器
 */
-(UIViewController *_Nonnull)topViewController;

@end

NS_ASSUME_NONNULL_END
