//
//  ViewSettings.m
//  InspirationBasic
//
//  Created by Timothy Swan on 7/30/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ViewSettings.h"

@implementation ViewSettings

- (id)    initWithFont:(UIFont  *)font
       backgroundColor:(UIColor *)backgroundColor
             textColor:(UIColor *)textColor
   textBackgroundColor:(UIColor *)textBackgroundColor
 positiveFeedbackColor:(UIColor *)positiveFeedbackColor
 negativeFeedbackColor:(UIColor *)negativeFeedbackColor {
    if (self = [super init]) {
        self.font = font;
        self.backgroundColor = backgroundColor;
        self.textColor = textColor;
        self.textBackgroundColor = textBackgroundColor;
        self.positiveFeedbackColor = positiveFeedbackColor;
        self.negativeFeedbackColor = negativeFeedbackColor;
    }
    return self;
}

- (void) setSettingsForCellWithNoSelectionColorAndIndentLines:(UITableViewCell *)cell indentString:(NSString *)indentString {
    //UIView *bgColorView = [[UIView alloc] init];
    //bgColorView.backgroundColor = [UIColor clearColor];
    //[cell setSelectedBackgroundView:bgColorView];
    [self setSettingsForCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, cell.contentView.bounds.size.width, 1)]; // Horizontal line
    //UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake((cell.contentView.bounds.size.width / 2), 0, 1, cell.contentView.bounds.size.height)]; // Vertical line
    
    NSString * string = cell.textLabel.text;
    //NSLog(@"%@",string);
    //NSLog(@"%d",cell.contentView.subviews.count);
    NSString * prefix = indentString;
    int i = 20;
    int tag = 10;
    while ([string hasPrefix:prefix]) {
        string = [string substringFromIndex:[prefix length]];
        if (![cell.contentView viewWithTag:tag]) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(i, 0, 2, cell.contentView.bounds.size.height)];
            lineView.tag = tag;
            lineView.backgroundColor = self.textColor;
            //lineView.autoresizingMask = 0x3f;
            [cell.contentView addSubview:lineView];
        }
        i += 15;
        tag += 1;
    }
    while ([cell.contentView viewWithTag:tag]) {
        [[cell.contentView viewWithTag:tag] removeFromSuperview];
        tag++;
    }
    //NSLog(@"%@",string);
}

- (void) setSettingsForCell:(UITableViewCell *)cell {
    [[cell textLabel] setFont:self.font];
    [[cell textLabel] setTextColor:self.textColor];
    [cell setBackgroundColor:self.textBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) setSettingsForTableView:(UITableView *)tableView {
    [tableView setBackgroundColor:self.backgroundColor];
}

- (void) setSettingsForTextView:(UITextView *)textView {
    [textView setFont:self.font];
    [textView setTextColor:self.textColor];
    [textView setBackgroundColor:self.backgroundColor];
}

- (void) setSettingsForTextField:(UITextField *)textField {
    [textField setFont:self.font];
    [textField setTextColor:self.textColor];
    [textField setBackgroundColor:self.backgroundColor];
    //textField.borderStyle=UITextBorderStyleNone;
    //textField.layer.cornerRadius=8.0f;
    //textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[(self.negativeFeedbackColor)CGColor];
    textField.layer.borderWidth= 2.0f;
}

- (void) setFeedbackForTextField:(UITextField *)textField to:(bool)positive {
    textField.layer.borderColor=[(positive ? self.positiveFeedbackColor : self.negativeFeedbackColor)CGColor];
}

- (void) setSettingsForView:(UIView *)view {
    [view setBackgroundColor:self.backgroundColor];
}

@end
