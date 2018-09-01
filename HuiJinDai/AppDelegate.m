//
//  AppDelegate.m
//  HuiJinDai
//
//  Created by 耿笑威 on 2018/8/30.
//  Copyright © 2018年 shanpx. All rights reserved.
//

#import "AppDelegate.h"
#import "HJDRegisterViewController.h"
#import "HJDHomeViewController.h"
#import "HJDMyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[HJDRegisterViewController alloc] init]];
    self.window.rootViewController = navi;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)enterHomeController {
    HJDHomeViewController *homeController = [[HJDHomeViewController alloc] init];
    homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:kImage(@"4.png") selectedImage:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeController];
    
    HJDMyViewController *myController = [[HJDMyViewController alloc] init];
    myController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:kImage(@"5.png") selectedImage:nil];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:myController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[ nav1, nav2 ];
    
    self.window.rootViewController = tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
