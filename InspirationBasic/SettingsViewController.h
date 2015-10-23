//
//  SettingsViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSettings.h"
#import "FCColorPickerViewController.h"
#import "FontViewController.h"
@protocol ViewResettable
- (void) resetView;
@end
@interface SettingsViewController : UITableViewController<FCColorPickerViewControllerDelegate, FontAccepter, HasBackButton>
@property id<ViewResettable> delegate;
@property ViewSettings * settings;
@end
