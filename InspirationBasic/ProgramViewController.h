//
//  TableViewController.h
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

#import "StatementHasStatementListVisitor.h"
#import "OutputListener.h" // remove later

@interface ProgramViewController : UITableViewController <OutputListener>

@property Program * program;

@property NSString * output; // Temporary

@property StatementHasStatementListVisitor * statementHasStatementListVisitor; // Made into a property for efficiency

@property (nonatomic) NSMutableArray * flattenedList;

- (void) initStatements;

- (IBAction)DeleteAll:(UIButton *)sender;

- (IBAction)DeleteProtectChildren:(UIButton *)sender;

- (IBAction)moveUp:(UIButton *)sender;

- (IBAction)moveDown:(UIButton *)sender;

@end
