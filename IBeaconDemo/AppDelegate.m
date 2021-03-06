//
//  AppDelegate.m
//  IBeaconDemo
//
//  Created by LPPZ-User01 on 2017/5/10.
//  Copyright © 2017年 LPPZ-User01. All rights reserved.
//

#import "AppDelegate.h"
@import  CoreLocation;

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (strong, nonatomic)CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        NSLog(@"这台设备可以检测到周围的beacon");
    }else {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
            NSLog(@"用户权限已经开启");
        }else {
            NSLog(@"用户没有开启权限，请开启权限以后再试。");
        }

    }

    return YES;
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
