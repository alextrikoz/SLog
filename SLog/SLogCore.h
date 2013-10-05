//
//  SLogCore.h
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLogGroup.h"

@interface SLogCore : NSObject

void SFreeAll(void);
void SFreeTag(NSString *tag);
void SRemoveTag(NSString *tag);
void SCreateTag(NSString *tag, STagStyle style);
void SLog(NSString *tag, NSString *format, ...);

@property (strong, nonatomic) SLogGroup *currentTag;
@property (strong, nonatomic) NSMutableArray *tags;

+ (SLogCore *)sharedSLogCore;
+ (void)presentConsole;
+ (void)hideConsole;

@end
