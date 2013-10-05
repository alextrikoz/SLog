//
//  SLogSuperCell.h
//  Demo
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLogMessage;

@protocol SLogSuperCell <NSObject>

@optional

+ (CGFloat)heightWithRepresentedObject:(NSString *)representedObject;

- (void)setRepresentedObject:(SLogMessage *)representedObject;

@end

@interface SLogSuperCell : UITableViewCell <SLogSuperCell>

@end
