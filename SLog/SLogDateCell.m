//
//  SLogDateCell.m
//  Demo
//
//  Created by Alexander on 09/29/13..
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "SLogDateCell.h"
#import "SLogMessage.h"

@interface SLogDateCell ()

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation SLogDateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.dateLabel = [UILabel new];
    self.dateLabel.font = [UIFont boldSystemFontOfSize:13];
    self.dateLabel.frame = CGRectMake(10, 4, 300, 0);
    [self addSubview:self.dateLabel];
    
    self.messageLabel = [UILabel new];
    self.messageLabel.font = [UIFont systemFontOfSize:13];
    self.messageLabel.frame = CGRectMake(10, 0, 300, 0);
    self.messageLabel.numberOfLines = 0;
    [self addSubview:self.messageLabel];
}

- (void)setRepresentedObject:(SLogMessage *)representedObject {
    [self.dateLabel setText:representedObject.date];
    [self.messageLabel setText:representedObject.message];
    
    CGRect frame = self.dateLabel.frame;
    frame.size.height = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:self.dateLabel.lineBreakMode].height;
    [self.dateLabel setFrame:frame];
    
    frame = self.messageLabel.frame;
    frame.origin.y = 4 + CGRectGetMaxY(self.dateLabel.frame);
    frame.size.height = [self.messageLabel.text sizeWithFont:self.messageLabel.font constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:self.messageLabel.lineBreakMode].height;
    [self.messageLabel setFrame:frame];
}

+ (CGFloat)heightWithRepresentedObject:(SLogMessage *)representedObject {
    float height = 4.0;
    height += [representedObject.date sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping].height;
    height += 4.0;
    height += [representedObject.message sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping].height;
    height += 4.0;
    return height;
}

@end
