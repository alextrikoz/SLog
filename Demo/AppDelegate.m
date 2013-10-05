//
//  AppDelegate.m
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "AppDelegate.h"

#import "SLogCore.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    SFreeTag(@"Info");
    SCreateTag(@"Info", STagStyleNoDate);
    SCreateTag(@"bla-bla-bla", STagStyleDate);
    
    SLog(@"Byron", @"Not in those climes where I have late been straying,");
    SLog(@"Byron", @"Though Beauty long hath there been matchless deemed,\nNot in those visions to the heart displaying");
    SLog(@"bla-bla-bla", @"aa");
    SLog(@"bla-bla-bla", @"bbb");
    SLog(@"bla-bla-bla", @"bb");
    SLog(@"bla-bla-bla", @"bb");
    SLog(@"bla-bla-bla", @"bb");
    SLog(@"Byron", @"Forms which it sighs but to have only dreamed,");
    SLog(@"Byron", @"Hath aught like thee in Truth or Fancy seemed:\nNor, having seen thee, shall I vainly seek,\nTo paint those charms which varied as they beamed—");
    SLog(@"Byron", @"To such as see thee not my words were weak;\nTo those who gaze on thee what language could they speak?");
    SLog(@"Random", @"ololo ololo I am driving UFO");
    SLog(@"Random", @"banana-banana");
    SLog(@"Random", @"banana-banana");
    SLog(@"Server", @"404 Not Found");
    SLog(@"Server", @"500 Internal Server Error");
    SLog(@"Server", @"%d OK", 200);
    
    SLog(@"Info", @"Revision: #%d", 100);
    SLog(@"Info", @"BaseUrl: %@", @"https://developer.apple.com/");
    srand(time(nil));
    SLog(@"Info", @"Random: %d", rand()%100);
    SLog(@"Info", @"Date: %@", [NSDate date]);
    
    SLog(@"Server", @"403 Forbidden");
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    return YES;
}

@end
