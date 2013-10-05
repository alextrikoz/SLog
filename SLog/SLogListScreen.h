//
//  SLogListScreen.h
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLogDetailedScreen;

@interface SLogListScreen : UITableViewController

@property (unsafe_unretained, nonatomic) SLogDetailedScreen *detailedController;

@end
