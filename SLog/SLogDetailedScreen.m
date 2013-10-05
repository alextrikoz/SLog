//
//  SLogDetailedScreen.m
//  SLog
//
//  Created by Alexander on 09/29/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogDetailedScreen.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "SLogMessage.h"
#import "SLogGroup.h"

#import "SLogCore.h"
#import "SLogSuperCell.h"
#import "SLogDateCell.h"
#import "SLogNoDateCell.h"

@interface SLogDetailedScreen () <MFMailComposeViewControllerDelegate>

@end

@implementation SLogDetailedScreen

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UpdateConsole" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
    }];
    
    self.navigationItem.title = [SLogCore sharedSLogCore].currentTag.tag;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(onMailClick:)];
}

- (void)onMailClick:(id)sender {
    if (![MFMailComposeViewController canSendMail]) {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Setup mail and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    
    NSMutableString *text = [NSMutableString string];
    switch ([SLogCore sharedSLogCore].currentTag.style) {
        case STagStyleDate:
            for (SLogMessage *message in [SLogCore sharedSLogCore].currentTag.messages) {
                [text appendString:[NSString stringWithFormat:@"%@ %@", message.date, message.message]];
                [text appendString:@"\n"];
            }
            break;
        case STagStyleNoDate:
            for (SLogMessage *message in [SLogCore sharedSLogCore].currentTag.messages) {
                [text appendString:[NSString stringWithFormat:@"%@", message.message]];
                [text appendString:@"\n"];
            }
            break;
        default:
            break;
    }
    
    [picker addAttachmentData:[text dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"text/plain" fileName:[[SLogCore sharedSLogCore].currentTag.tag stringByAppendingPathExtension:@"txt"]];
    [picker setSubject:@"Console"];
    [self presentModalViewController:picker animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SLogCore sharedSLogCore].currentTag.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([SLogCore sharedSLogCore].currentTag.style) {
        case STagStyleDate:
            return [SLogDateCell heightWithRepresentedObject:[SLogCore sharedSLogCore].currentTag.messages[indexPath.row]];
        default:
            return [SLogNoDateCell heightWithRepresentedObject:[SLogCore sharedSLogCore].currentTag.messages[indexPath.row]];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *dateIdentifier = @"STagStyleDate";
    static NSString *noDateIdentifier = @"STagStyleNoDate";
    SLogSuperCell *cell;
    switch ([SLogCore sharedSLogCore].currentTag.style) {
        case STagStyleDate:
            cell = [tableView dequeueReusableCellWithIdentifier:dateIdentifier];
            if (!cell) {
                cell = [[SLogDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dateIdentifier];
            }
            break;            
        case STagStyleNoDate:
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:noDateIdentifier];
            if (!cell) {
                cell = [[SLogNoDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDateIdentifier];
            }
            break;
    }
    
    cell.representedObject = [SLogCore sharedSLogCore].currentTag.messages[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController {
    barButtonItem.title = @"Master";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

@end
