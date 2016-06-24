//
//  AppDelegate.m
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeController.h"
#import "GalleryController.h"
#import "LikesController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeController *homeController = [[HomeController alloc] init];
    homeController.tabBarItem.image = [UIImage imageNamed:@"home_icon"];
    homeController.tabBarItem.selectedImage = [UIImage imageNamed:@"home_icon_filled"];
    homeController.tabBarItem.title = @"Home";
    
    GalleryController *galleryController = [[GalleryController alloc] init];
    galleryController.tabBarItem.image = [UIImage imageNamed:@"gallery_icon"];
    galleryController.tabBarItem.selectedImage = [UIImage imageNamed:@"gallery_icon_filled"];
    galleryController.tabBarItem.title = @"Gallery";
    
    LikesController *likesController = [[LikesController alloc] init];
    likesController.tabBarItem.image = [UIImage imageNamed:@"heart_icon"];
    likesController.tabBarItem.selectedImage = [UIImage imageNamed:@"heart_icon_filled"];
    likesController.tabBarItem.title = @"Likes";
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.tabBar.tintColor = [UIColor orangeColor];
    tabController.viewControllers = @[homeController,
                                      galleryController,
                                      likesController];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabController];
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
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