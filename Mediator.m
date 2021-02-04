//
//  Mediator.m
//  comment
//
//  Created by 陈刚 on 16/12/29.
//  Copyright © 2016年 DAZHONG. All rights reserved.
//

#import "MediatorManager.h"
#import <objc/runtime.h>
@interface MediatorManager()
@property (nonatomic,strong,nullable) NSMutableDictionary <NSString * , Class > * cacheDics;
@end
@implementation MediatorManager
/*
    初始化单例
 */
+ (MediatorManager *_Nonnull)sharedInstence
{
    static MediatorManager *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[[self class] alloc] init];
    });
    return inst;
}
- (NSMutableDictionary<NSString *,Class> *)cacheDics
{
    if (!_cacheDics) {
        _cacheDics = [[NSMutableDictionary alloc] init];
    }
    return  _cacheDics;
}
/**  有参数跳转界面
 * @param className  要push的界面类名
 * @param dic        界面所需参数字典
 */
-(void)pushViewController:(NSString *)className withPropertyValueDic:(NSMutableDictionary *)dic animated:(BOOL)animated
{
    //根据字符串创建类
    Class toClass = [self checkClassFromClassName:className];
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC =  [self setClass:toClass PropetyValue:dic];
    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController pushViewController:nextVC animated:animated];
}
/**  有参数跳转界面
 * @param className  要present的界面类名
 * @param dic        界面所需参数字典
 */
-(void)presentiewController:(NSString *)className withPropertyValueDic:(NSMutableDictionary *)dic animated:(BOOL)animated
{
    //根据类名获取类
    Class toClass = [self checkClassFromClassName:className];
    //创建对象(写到这里已经可以进行随机页面跳转了)
    id nextVC = [self setClass:toClass PropetyValue:dic];
    
    //获取当前控制器进行跳转界面
    [[self topViewController].navigationController presentViewController:nextVC animated:animated completion:nil];
}
/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
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
/*
 设置对象的属性
 */
- (id)setClass:(Class)toClass PropetyValue:(NSMutableDictionary*_Nullable)dic
{
    id nextVC = [[toClass alloc] init];
    if (dic == nil) {
        return nextVC;
    }
    //根据传进来的字典 ，跳转界面传参数赋值
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:nextVC verifyPropertyName:key]) {
            //kvc给属性赋值
            [nextVC setValue:obj forKey:key];
        }else {
            NSLog(@"%@===不包含key=%@的属性",[nextVC description],key);
        }
    }];
    return nextVC;
}
- (Class)checkClassFromClassName:(NSString *)className
{
    Class toClass;
    //获取cache
    if (![self.cacheDics objectForKey:className]) {
        //根据字符串创建类
        const char *class = [className cStringUsingEncoding:NSASCIIStringEncoding];
        //根据类名获取类
        toClass = objc_getClass(class);
        NSString *str = [NSString stringWithFormat:@"%@====还未创建",className];
        NSAssert(toClass, str);
        [self.cacheDics setValue:toClass forKey:className];
    } else {
        toClass = [self.cacheDics objectForKey:className];
    }
    return toClass;
}

#pragma mark - 获取当前控制器
- (UIViewController *)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
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
