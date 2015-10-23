//
//  FontFamilyViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 8/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSettings.h"
#import "FontViewController.h"
@interface FontFamilyViewController : UITableViewController<FontAccepter>
@property id<FontAccepter> delegate;
@property ViewSettings * settings;
@property NSArray * fonts;
@end
