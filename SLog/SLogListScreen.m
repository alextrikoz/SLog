//
//  SLogListScreen.m
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogListScreen.h"

#import "SLogCore.h"
#import "SLogDetailedScreen.h"

@implementation SLogListScreen

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:[SLogCore class] action:@selector(hideConsole)];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UpdateConsole" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [SLogCore sharedSLogCore].tags.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = nil;
        SLogGroup *group = [SLogCore sharedSLogCore].tags[indexPath.row];
        cell.textLabel.text = group.tag;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.image = [UIImage imageNamed:@"Trash.png"];
        cell.textLabel.text = @"Clear";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [SLogCore sharedSLogCore].currentTag = [SLogCore sharedSLogCore].tags[indexPath.row];
    } else {
        [SLogCore sharedSLogCore].currentTag = nil;
        SFreeAll();
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0) {
            [self.navigationController pushViewController:[SLogDetailedScreen new] animated:YES];
        }
    } else {
        [self.detailedController.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SLogGroup *group = [SLogCore sharedSLogCore].tags[indexPath.row];
        SRemoveTag(group.tag);
    } else {
        SFreeAll();
    }
}

@end
