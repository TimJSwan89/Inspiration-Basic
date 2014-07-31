//
//  ProgramListViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableViewController.h"
#import "ViewSettings.h"

@interface ProgramListViewController : UITableViewController<ScopeFinder, VarAccepter, UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray * programs;
@property bool editingState;
@property ViewSettings * settings;
- (IBAction)ToggleEdit:(UIBarButtonItem *)sender;
- (IBAction)savePrograms:(UIBarButtonItem *)sender;

@end
