//
//  TableViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ComponentViewController.h" // For ElementAccepter
#import "ElementViewController.h"
#import "ViewSettings.h"
#import "OutputViewController.h"
@class ProgramViewController;
#import "StatementHasStatementListVisitor.h"

@protocol ProgramExecutionDelegate
- (void) program:(Program *)program isExecuting:(bool)flag underVC:(ProgramViewController *)pvc;
@end

@protocol Saveable
- (void) save;
@end

@interface ProgramViewController : UITableViewController <ElementAccepter, Reloadable, SpecificScopeFinder, ExecutionDelegate, HasBackButton>

@property Program * program;

@property (nonatomic) NSMutableArray * flattenedList;
@property ViewSettings * settings;
@property (nonatomic) bool inserting;
@property (nonatomic) NSString * indentString;
@property (nonatomic) id <Saveable, ProgramExecutionDelegate> delegate;
@property (nonatomic) OutputViewController * executingViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * runButton;
@property bool running;
@property bool emptyState;

- (void) reload;

- (void) acceptElement:(id)element;

- (void) finishedExecuting;
- (NSMutableArray *) getScope:(int)type;

- (IBAction)deleteAll:(UIButton *)sender;

- (IBAction)deleteProtectChildren:(UIButton *)sender;

- (IBAction)moveUp:(UIButton *)sender;

- (IBAction)moveDown:(UIButton *)sender;

- (IBAction)insertAfter:(UIButton *)sender;
- (IBAction)Run:(UIBarButtonItem *)sender;
- (void)popQuick;
@end
