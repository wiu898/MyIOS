//
//  AppDelegate.m
//  DouYU
//
//  Created by 李超 on 16/3/22.
//  Copyright © 2016年 cn.com.XC. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import "BaseTabBarController.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UMessage startWithAppkey:@"5642a2b967e58ef78e006937" launchOptions:launchOptions];
    
    [self setNotifition];
    
    [self initRootWindow];
    
    return YES;
}

- (void)setNotifition{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    if (UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        
        action1.identifier = @"action1_identifier";
        action1.title = @"Accept";
        
        //当点击的时候启动程序
        action1.activationMode = UIUserNotificationActivationModeForeground;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
        
        action1.identifier = @"action2_identifier";
        action2.title = @"Reject";
        
        //当点击的时候程序不启动
        action2.activationMode = UIUserNotificationActivationModeBackground;
     
        //需要解锁才能处理
        action2.authenticationRequired = YES;
        
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1"; //这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSetting = [UIUserNotificationSettings settingsForTypes:  UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
            categories:[NSSet setWithObject:categorys]];
        
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSetting];
    }else{
    
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
    
#else
    
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];

#endif
    
    [UMessage setLogEnabled:YES];
    
}

- (void)initRootWindow{

    BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window setRootViewController:rootVC];
    
    [self.window addSubview:rootVC.view];
    
    [self.window makeKeyAndVisible];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSLog(@"Error :%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //关闭弹出框
    [UMessage didReceiveRemoteNotification:userInfo];
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
