//
//  SLogGroup.m
//  Demo
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogGroup.h"

@implementation SLogGroup

- (id)init {
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray array];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.style = [[decoder decodeObjectForKey:@"style"] intValue];
        self.tag = [decoder decodeObjectForKey:@"tag"];
        self.messages = [decoder decodeObjectForKey:@"messages"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:@(self.style) forKey:@"style"];
    [coder encodeObject:self.tag forKey:@"tag"];
    [coder encodeObject:self.messages forKey:@"messages"];
}

@end
