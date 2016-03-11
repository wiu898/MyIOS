//
//  AppDelegate.m
//  PodTest
//
//  Created by 李超 on 15/11/26.
//  Copyright © 2015年 cn.com.李超. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "AccountManager.h"
#import <EaseMobHeaders.h>
#import "FirstViewController.h"
#import "SubjectFirstViewController.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>

@interface AppDelegate ()
@property (strong, nonatomic)  MainViewController *main;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor clearColor];
    
    self.main = [[MainViewController alloc] init];
    
    UINavigationController *mainNav = [[UINavigationController alloc]
                    initWithRootViewController:_main];
    
    self.window.rootViewController = mainNav;
//    UITabBarController *tab = [[UITabBarController alloc] init];
//    
//    tab.viewControllers = @[[[FirstViewController alloc] init]
//                            ,[[SubjectFirstViewController alloc] init]];
//    
//    self.window.backgroundColor = [UIColor clearColor];
//    
//    self.window.rootViewController = tab;
    
    [self.window makeKeyAndVisible];
    
    if (![AccountManager isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.window.rootViewController presentViewController:login
                 animated:YES completion:nil];
    }
    
    
    return YES;
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
