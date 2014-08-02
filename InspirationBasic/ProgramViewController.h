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

#import "StatementHasStatementListVisitor.h"

@protocol Saveable
- (void) save;
@end

@interface ProgramViewController : UITableViewController <ElementAccepter, Reloadable, SpecificScopeFinder, ExecutionDelegate>

@property Program * program;

@property (nonatomic) NSMutableArray * flattenedList;
@property ViewSettings * settings;
@property (nonatomic) bool inserting;
@property (nonatomic) NSString * indentString;
@property (nonatomic) id <Saveable> delegate;

- (void) reload;

- (void) acceptElement:(id)element;

- (void) finishedExecuting;

- (NSMutableArray *) getScope:(int)type;

- (IBAction)deleteAll:(UIButton *)sender;

- (IBAction)deleteProtectChildren:(UIButton *)sender;

- (IBAction)moveUp:(UIButton *)sender;

- (IBAction)moveDown:(UIButton *)sender;

- (IBAction)insertAfter:(UIButton *)sender;

@end
