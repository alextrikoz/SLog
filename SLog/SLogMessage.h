//
//  SLogMessage.h
//  Demo
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLogMessage : NSObject <NSCoding>

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *message;

@end
