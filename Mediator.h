//
//  Mediator.h
//  comment
//
//  Created by 陈刚 on 16/12/29.
//  Copyright © 2016年 DAZHONG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mediator : NSObject

/**  push有参数跳转界面
 * @param className  要push的界面类名
 */
+(void)pushToControll:(NSString *)className;

/**  push有参数跳转界面
 * @param className  要push的界面类名
 * @param dic        界面所需参数字典
 */
+(void)pushToControll:(NSString *)className
 withPropertyValueDic:(NSMutableDictionary *)dic;

/**  present无参数跳转界面
 * @param className  要present的界面类名
 */
+(void)presentToControll:(NSString *)className;

/**  present有参数跳转界面
 * @param className  要present的界面类名
 * @param dic        界面所需参数字典
 */
+(void)presentToControll:(NSString *)className
    withPropertyValueDic:(NSMutableDictionary *)dic;

/**  退出登录
 * @param className  登录界面的类名
 * @param navClassName  导航控制器的类名
 */
+(void)loginOutWithLoginClass:(NSString *)className
                     withNavC:(NSString *)navClassName;

/**  退出登录
 * @return UIViewController  当前根控制器
 */
+ (UIViewController *)topViewController;

@end