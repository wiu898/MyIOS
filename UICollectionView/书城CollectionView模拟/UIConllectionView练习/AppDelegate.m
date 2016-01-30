//
//  AppDelegate.m
//  UIConllectionView练习
//
//  Created by 李超 on 15/11/19.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *viewController = [[ViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor lightGrayColor];
    
    [self.window makeKeyAndVisible];
    
    //IOS8以后推送通知要先注册
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert
              categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else{    //8.0之前的方法
        
      [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
        
    }
    
    return YES;
}

//获取token,将token保存到应用服务器中
-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSLog(@"Receive DeviceToken:%@",deviceToken);
    
}

//注册消息推送失败
- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSLog(@"Register Remote Notifications error:{%@}",error);

}

//处理收到的消息推送
- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    NSLog(@"Receive remote notification:%@",userInfo);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                        message:@"推送成功"
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action) {
                                            
                                            NSLog(@"消息推送成功");
                                            
                                        }];
    
    [alertController addAction:alertAction];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
