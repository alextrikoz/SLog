//
//  SLogGroup.h
//  Demo
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    STagStyleDate,
    STagStyleNoDate
} STagStyle;

@interface SLogGroup : NSObject <NSCoding>

@property (assign, nonatomic) STagStyle style;
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSMutableArray *messages;

@end
