//
//  ViewController.m
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "ViewController.h"

#import "SLogCore.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Present Console" forState:UIControlStateNormal];
    
    [button sizeToFit];
    
    self.navigationItem.titleView = button;
}

- (void)onButtonClick:(id)sender {
    [SLogCore presentConsole];
}

@end
