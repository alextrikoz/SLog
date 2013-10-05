//
//  SLogCore.m
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogCore.h"

#import "SLogMessage.h"
#import "SLogListScreen.h"
#import "SLogDetailedScreen.h"

@interface SLogCore ()

@property (strong, nonatomic) UIViewController *screen;
@property (strong, nonatomic) UIWindow *window;

SLogGroup *groupWithTag(NSString *tag);
void writeTagsToFileAndPostNotification();

@end

@implementation SLogCore

+ (void)presentConsole {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentModalViewController:[SLogCore sharedSLogCore].screen animated:YES];
    } else {
        CGRect frame = [SLogCore sharedSLogCore].window.frame;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                frame.origin.x = frame.size.width;
                break;
            case UIInterfaceOrientationLandscapeRight:
                frame.origin.x = -frame.size.width;
                break;
            case UIInterfaceOrientationPortrait:
                frame.origin.y = frame.size.height;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                frame.origin.y = -frame.size.height;
                break;
            default:
                break;
        }
        [SLogCore sharedSLogCore].window.frame = frame;
        [SLogCore sharedSLogCore].window.hidden = NO;
        
        frame.origin = CGPointZero;
        [UIView animateWithDuration:0.3 animations:^{
            [SLogCore sharedSLogCore].window.frame = frame;
        }];
    }
}

+ (void)hideConsole {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissModalViewControllerAnimated:YES];
    } else {
        CGRect frame = [SLogCore sharedSLogCore].window.frame;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                frame.origin.x = frame.size.width;
                break;
            case UIInterfaceOrientationLandscapeRight:
                frame.origin.x = -frame.size.width;
                break;
            case UIInterfaceOrientationPortrait:
                frame.origin.y = frame.size.height;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                frame.origin.y = -frame.size.height;
                break;
            default:
                break;
        }
        [UIView animateWithDuration:0.3 animations:^{
            [SLogCore sharedSLogCore].window.frame = frame;
        } completion:^(BOOL finished) {
            [SLogCore sharedSLogCore].window.hidden = YES;
        }];
    }
}

+ (SLogCore *)sharedSLogCore {
    static SLogCore *_sharedSLogCore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSLogCore = [self new];
    });
    return _sharedSLogCore;
}

- (id)init {
    self = [super init];
    if (self) {
        self.tags = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/slog.dat"]];
        if (!self.tags) {
            self.tags = [NSMutableArray array];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            self.screen = [[UINavigationController alloc] initWithRootViewController:[SLogListScreen new]];
        } else {
            UISplitViewController *split = [UISplitViewController new];
            SLogListScreen *masterController = [SLogListScreen new];
            SLogDetailedScreen *detailedController = [SLogDetailedScreen new];
            UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterController];
            masterController.detailedController = detailedController;
            UINavigationController *detailedNavigationController = [[UINavigationController alloc] initWithRootViewController:detailedController];
            split.delegate = detailedController;
            split.viewControllers = @[masterNavigationController, detailedNavigationController];
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.window.rootViewController = split;
        }
    }
    return self;
}

void SFreeAll(void) {
    NSMutableArray *tags = [SLogCore sharedSLogCore].tags;
    [[tags valueForKey:@"messages"] makeObjectsPerformSelector:@selector(removeAllObjects)];
    writeTagsToFileAndPostNotification();
}

void SFreeTag(NSString *tag) {
    SLogGroup *group = groupWithTag(tag);
    group.messages = [NSMutableArray array];
    writeTagsToFileAndPostNotification();
}

void SRemoveTag(NSString *tag) {
    SLogGroup *group = groupWithTag(tag);
    [[SLogCore sharedSLogCore].tags removeObject:group];
    writeTagsToFileAndPostNotification();
}

void SCreateTag(NSString *tag, STagStyle style) {
    SLogGroup *group = groupWithTag(tag);
    group.style = style;
    writeTagsToFileAndPostNotification();
}

void SLog(NSString *tag, NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"%@", string);
    
    SLogGroup *group = groupWithTag(tag);
    
    SLogMessage *message = [SLogMessage new];
    message.date = [[NSDate date] description];
    message.message = string;
    [group.messages addObject:message];
    
    writeTagsToFileAndPostNotification();
}

SLogGroup *groupWithTag(NSString *tag) {
    NSMutableArray *tags = [SLogCore sharedSLogCore].tags;
    NSUInteger indexOfObject = [tags indexOfObjectPassingTest:^(SLogGroup *obj, NSUInteger idx, BOOL *stop) {
        return [obj.tag isEqualToString:tag];
    }];
    
    SLogGroup *group;
    if (indexOfObject == NSNotFound) {
        group = [SLogGroup new];
        group.tag = tag;
        [tags addObject:group];
    } else {
        group = tags[indexOfObject];
    }
    return group;
}

void writeTagsToFileAndPostNotification() {
    NSMutableArray *tags = [SLogCore sharedSLogCore].tags;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/slog.dat"];
    [NSKeyedArchiver archiveRootObject:tags toFile:path];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateConsole" object:nil];
}

@end
