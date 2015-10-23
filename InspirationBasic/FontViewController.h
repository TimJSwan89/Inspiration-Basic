//
//  FontViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSettings.h"
@protocol FontAccepter
- (void) acceptFont:(NSString *)font;
@end
@interface FontViewController : UITableViewController
@property id<FontAccepter> delegate;
@property ViewSettings * settings;
@property NSArray * fonts;
@end
