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

#import "StatementHasStatementListVisitor.h"
#import "OutputListener.h" // remove later

@interface ProgramViewController : UITableViewController <OutputListener, ElementAccepter, Reloadable>

@property Program * program;

@property NSString * output; // Temporary

@property StatementHasStatementListVisitor * statementHasStatementListVisitor; // Made into a property for efficiency

@property (nonatomic) NSMutableArray * flattenedList;

- (void) initStatements;

- (void) reload;

- (void) acceptElement:(id)element;

- (IBAction)deleteAll:(UIButton *)sender;

- (IBAction)deleteProtectChildren:(UIButton *)sender;

- (IBAction)moveUp:(UIButton *)sender;

- (IBAction)moveDown:(UIButton *)sender;

@end
