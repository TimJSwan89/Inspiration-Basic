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
#import "ProgramViewController.h"
#import "DBInterface.h"
#import "SettingsViewController.h"

@interface ProgramListViewController : UITableViewController<ScopeFinder, VarAccepter, Saveable, UITableViewDelegate, UITableViewDataSource, ViewResettable, ProgramExecutionDelegate>

@property NSMutableArray * wrappedPrograms;
@property bool editingState;
@property bool renamingState;
@property ViewSettings * settings;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * renameButton;
@property DBInterface * interface;
- (IBAction)ToggleEdit:(UIBarButtonItem *)sender;
- (IBAction)renamePrograms:(UIBarButtonItem *)sender;
- (void) save;
- (void) resetView;
- (void) program:(Program *)program isExecuting:(bool)flag underVC:(ProgramViewController *)pvc;
@end
