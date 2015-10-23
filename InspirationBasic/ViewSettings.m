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
#import "StatementCell.h"

@implementation ViewSettings

- (id)          initWithFont:(UIFont  *)font
             backgroundColor:(UIColor *)backgroundColor
                   textColor:(UIColor *)textColor
         textBackgroundColor:(UIColor *)textBackgroundColor
       positiveFeedbackColor:(UIColor *)positiveFeedbackColor
       negativeFeedbackColor:(UIColor *)negativeFeedbackColor
navigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor
navigationBarForegroundColor:(UIColor *)navigationBarForegroundColor
    navigationBarButtonColor:(UIColor *)navigationBarButtonColor
                 buttonColor:(UIColor *)buttonColor
          statusBarTextWhite:(int)statusBarTextWhite; /* 0: auto 1: black 2: white */ {
    if (self = [super init]) {
        self.font = font;
        self.backgroundColor = backgroundColor;
        self.textColor = textColor;
        self.textBackgroundColor = textBackgroundColor;
        self.positiveFeedbackColor = positiveFeedbackColor;
        self.negativeFeedbackColor = negativeFeedbackColor;
        self.navigationBarBackgroundColor = navigationBarBackgroundColor;
        self.navigationBarForegroundColor = navigationBarForegroundColor;
        self.navigationBarButtonColor = navigationBarButtonColor;
        self.buttonColor = buttonColor;
        self.statusBarTextWhite = statusBarTextWhite;
    }
    return self;
}

- (void) setSettingsForCellWithNoSelectionColorAndIndentLines:(StatementCell *)cell indentString:(NSString *)indentString {
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
    [cell layoutSubviews];
    [cell reduceSize:i];
    cell.textLabel.text = string;
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

- (void) setSettingsForNavigationBarAndStatusBar:(UINavigationController *) navigationController {
    UIBarStyle style;
    if (self.statusBarTextWhite == 0) /* 0: auto 1: black 2: white */ {
        const CGFloat * colors = CGColorGetComponents(self.navigationBarBackgroundColor.CGColor);
        CGFloat red = colors[0];
        CGFloat green = colors[1];
        CGFloat blue = colors[2];
        //CGFloat alpha = colors[3];
        float brightness = (red / 255.0) * 0.3 + (green / 255.0) * 0.59 + (blue / 255.0) * 0.11;
        if (brightness > 0.0038998255 / 2 + 0.000013039953) {
            style = UIBarStyleDefault;
        } else {
            style = UIBarStyleBlackTranslucent;
        }
    } else if (self.statusBarTextWhite == 1) {
        style = UIBarStyleDefault;
    } else {
        style = UIBarStyleBlackTranslucent;
    }
    navigationController.navigationBar.barStyle = style;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // iOS 6.1 or earlier
        navigationController.navigationBar.tintColor = self.navigationBarBackgroundColor;
    } else {
        // iOS 7.0 or later
        navigationController.navigationBar.barTintColor = self.navigationBarBackgroundColor;
        navigationController.navigationBar.tintColor = self.navigationBarButtonColor;
        //self.navigationController.navigationBar.translucent = NO;
    }
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : self.navigationBarForegroundColor}];
    
    //self.navigationController.navigationBar.translucent = NO;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self setNeedsStatusBarAppearanceUpdate];
}

- (void) setSettingsForButton:(UIButton *)button {
    [button setTintColor:self.buttonColor];
}

//- (void) setSettingsForUIBarButtonItem:(UIBarButtonItem *)buttonItem {
//    [buttonItem setTintColor:[UIColor yellowColor]];
//}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (UIBarButtonItem *) getBackArrowWithReceiver:(id <HasBackButton>)receiver {

    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithTitle:@"˿" style:UIBarButtonItemStyleBordered target:receiver action:@selector(popQuick)];

    [left setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"Chalkduster" size:85.0], NSFontAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    return left;
}
#pragma clang diagnostic pop

@end
