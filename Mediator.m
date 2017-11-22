//
//  Mediator.m
//  comment
//
//  Created by 陈刚 on 16/12/29.
//  Copyright © 2016年 DAZHONG. All rights reserved.
//

#import "Mediator.h"
#import <objc/runtime.h>
@implementation Mediator

/**  有参数跳转界面
 * @param className  要push的界面类名
 */
+(void)pushToControll:(NSString *)className
{
    //根据字符串创建类
    const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class toClass = objc_getClass(class);
    if (!toClass) {
        #ifdef DEBUG
        //传参数类不存在不做跳转，并弹出提示
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"跳转的界面还未创建" preferredStyle:UIAlertControllerStyleAlert];
        
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
        
        return;
        #else
        return;

        #endif
    }
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [[toClass alloc] init];

    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController pushViewController:nextVC animated:YES];

}

/**  有参数跳转界面
 * @param className  要push的界面类名
 * @param dic        界面所需参数字典
 */
+(void)pushToControll:(NSString *)className withPropertyValueDic:(NSMutableDictionary *)dic
{
    //根据字符串创建类
    const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class toClass = objc_getClass(class);
    if (!toClass) {
#ifdef DEBUG
        //传参数类不存在不做跳转，并弹出提示
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"跳转的界面还未创建" preferredStyle:UIAlertControllerStyleAlert];
        
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
        return;
#else
        return;
        
#endif
    }
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [[toClass alloc] init];
    
    //根据传进来的字典 ，跳转界面传参数赋值
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:nextVC verifyPropertyName:key]) {
            //kvc给属性赋值
            [nextVC setValue:obj forKey:key];
        }else {
            NSLog(@"这个类不包含key=%@的属性",key);
        }
    }];
    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController pushViewController:nextVC animated:YES];
}

/**  无参数跳转界面
 * @param className  要present的界面类名
 */
+(void)presentToControll:(NSString *)className
{
    //根据字符串创建类
    const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class toClass = objc_getClass(class);
    if (!toClass) {
#ifdef DEBUG

        //传参数类不存在不做跳转，并弹出提示
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"跳转的界面还未创建" preferredStyle:UIAlertControllerStyleAlert];
        
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
        return;
#else
        return;
        
#endif
    }
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [[toClass alloc] init];
    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController presentViewController:nextVC animated:YES completion:nil];

}

/**  有参数跳转界面
 * @param className  要present的界面类名
 * @param dic        界面所需参数字典
 */
+(void)presentToControll:(NSString *)className withPropertyValueDic:(NSMutableDictionary *)dic
{
    //根据字符串创建类
    const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class toClass = objc_getClass(class);
    if (!toClass) {
#ifdef DEBUG
        
        //传参数类不存在不做跳转，并弹出提示
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"跳转的界面还未创建" preferredStyle:UIAlertControllerStyleAlert];
        
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
        return;
#else
        return;
        
#endif
    }
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [[toClass alloc] init];
    
    //根据传进来的字典 ，跳转界面传参数赋值
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:nextVC verifyPropertyName:key]) {
            //kvc给属性赋值
            [nextVC setValue:obj forKey:key];
        }else {
            NSLog(@"这个类不包含key=%@的属性",key);
        }
    }];

    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController presentViewController:nextVC animated:YES completion:nil];
}

/**  退出登录
 * @param className  登录界面的类名
 * @param navClassName  导航控制器的类名
 */

+(void)loginOutWithLoginClass:(NSString *)className withNavC:(NSString *)navClassName
{
    //根据字符串创建类
    const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class toClass = objc_getClass(class);
    
    //根据字符串创建类
    const char *nav = [navClassName cStringUsingEncoding:NSASCIIStringEncoding];
    //根据类名获取类
    Class navClass = objc_getClass(nav);
    if (!toClass||!navClass) {
#ifdef DEBUG
        //传参数类不存在不做跳转，并弹出提示
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"跳转的界面还未创建" preferredStyle:UIAlertControllerStyleAlert];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        });
        
        return;
#else
        return;
        
#endif
    }
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [[toClass alloc] init];
    id navC = [[navClass alloc] initWithRootViewController:nextVC];
    
    if ([[chiveDataManager sharedChive] RemoveFileWithPath:@"userInfo"]) {
        
        [UIApplication sharedApplication].keyWindow.rootViewController = navC;
        
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
        
    }else{
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"退出登录失败" preferredStyle:UIAlertControllerStyleAlert];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        
    }
}


/**
 *  检测对象是否存在该属性
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

#pragma mark - 获取当前控制器
+ (UIViewController *)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
        
    }else if (rootViewController.presentedViewController){
        
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    }else{
        return  rootViewController;
    }
}

@end
