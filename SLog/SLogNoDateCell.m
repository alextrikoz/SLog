//
//  SLogNoDateCell.m
//  SLog
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogNoDateCell.h"

#import "SLogMessage.h"

@interface SLogNoDateCell ()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation SLogNoDateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {    
    self.messageLabel = [UILabel new];
    self.messageLabel.font = [UIFont systemFontOfSize:13];
    self.messageLabel.frame = CGRectMake(10, 8, 300, 0);
    self.messageLabel.numberOfLines = 0;
    [self addSubview:self.messageLabel];
}

- (void)setRepresentedObject:(SLogMessage *)representedObject {
    [self.messageLabel setText:representedObject.message];
    
    CGRect frame = self.messageLabel.frame;
    frame.size.height = [self.messageLabel.text sizeWithFont:self.messageLabel.font constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:self.messageLabel.lineBreakMode].height;
    [self.messageLabel setFrame:frame];
}

+ (CGFloat)heightWithRepresentedObject:(SLogMessage *)representedObject {
    CGFloat height = 8.0;
    height += [representedObject.message sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping].height;
    height += 8.0;
    
    return height;
}

@end
