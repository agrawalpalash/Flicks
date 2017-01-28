//
//  AppDelegate.m
//  Flicks
//
//  Created by  Palash Agrawal on 1/23/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Set up the first View Controller
    ViewController *nowPlaying = [storyBoard instantiateViewControllerWithIdentifier:@"viewController"];
    nowPlaying.title = @"Flicks";
    nowPlaying.restorationIdentifier = @"now_playing";
    nowPlaying.view.backgroundColor = [UIColor orangeColor];
    nowPlaying.tabBarItem.title = @"Now Playing";
    nowPlaying.tabBarItem.image = [UIImage imageNamed:@"iconmonstr-video-8-24.png"];
    
    // Set up Navigation Bar
    UINavigationController *nowPlayingNavController = [[UINavigationController alloc] initWithRootViewController:nowPlaying];
    nowPlayingNavController.title = @"Flicks";
    nowPlayingNavController.view.backgroundColor = [UIColor orangeColor];
    
    // Set up the second View Controller
    ViewController *topRated = [storyBoard instantiateViewControllerWithIdentifier:@"viewController"];
    topRated.title = @"Flicks";
    topRated.restorationIdentifier = @"top_rated";
    topRated.view.backgroundColor = [UIColor orangeColor];
    topRated.tabBarItem.title = @"Top Rated";
    topRated.tabBarItem.image = [UIImage imageNamed:@"iconmonstr-star-6-24.png"];
    
    // Set up Navigation Bar
    UINavigationController *topRatedNavController = [[UINavigationController alloc] initWithRootViewController:topRated];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // Set up the Tab Bar Controller to have two tabs
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[nowPlayingNavController, topRatedNavController]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor orangeColor]];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
    // Make the Tab Bar Controller the root view controller
    self.window.rootViewController = tabBarController;
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
