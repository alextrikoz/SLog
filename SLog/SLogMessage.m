//
//  SLogMessage.m
//  Demo
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogMessage.h"

@implementation SLogMessage

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.message = [decoder decodeObjectForKey:@"message"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.message forKey:@"message"];
}

@end
