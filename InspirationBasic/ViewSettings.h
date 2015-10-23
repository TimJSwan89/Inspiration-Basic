//
//  ViewSettings.h
//  InspirationBasic
//
//  Created by Timothy Swan on 7/30/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HasBackButton
- (void) popQuick;
@end

@interface ViewSettings : NSObject

@property UIFont * font;
@property UIColor * backgroundColor;
@property UIColor * textColor;
@property UIColor * textBackgroundColor;
@property UIColor * positiveFeedbackColor;
@property UIColor * negativeFeedbackColor;
@property UIColor * navigationBarBackgroundColor;
@property UIColor * navigationBarForegroundColor;
@property UIColor * navigationBarButtonColor;
@property UIColor * buttonColor;
@property int statusBarTextWhite; // 0: auto 1: black 2: white


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
          statusBarTextWhite:(int)statusBarTextWhite;

- (void) setSettingsForCellWithNoSelectionColorAndIndentLines:(UITableViewCell *)cell indentString:(NSString *)indentString;
- (void) setSettingsForCell:(UITableViewCell *)cell;
- (void) setSettingsForTableView:(UITableView *)tableView;
- (void) setSettingsForTextView:(UITextView *)textView;
- (void) setSettingsForTextField:(UITextField *)textField;
- (void) setFeedbackForTextField:(UITextField *)textField to:(bool)positive;
- (void) setSettingsForView:(UIView *)view;
- (void) setSettingsForNavigationBarAndStatusBar:(UINavigationController *) navigationController;
- (void) setSettingsForButton:(UIButton *)button;
- (UIBarButtonItem *) getBackArrowWithReceiver:(id <HasBackButton>)receiver;

@end
