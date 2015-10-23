//
//  StatementComponentViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ComponentViewController.h"

#import "./BoolVariable.h"
#import "./IntVariable.h"
#import "./BoolArrayElement.h"
#import "./IntArrayElement.h"
#import "./IntValue.h"
#import "./BoolValue.h"
#import "./IntRandom.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
#import "./BoolRandom.h"
#import "./BoolNegation.h"
#import "./BoolOr.h"
#import "./BoolNor.h"
#import "./BoolAnd.h"
#import "./BoolNand.h"
#import "./BoolImplies.h"
#import "./BoolNonImplies.h"
#import "./BoolReverseImplies.h"
#import "./BoolReverseNonImplies.h"
#import "./BoolBoolEquals.h"
#import "./BoolBoolDoesNotEqual.h"
#import "./BoolIntEquals.h"
#import "./BoolIntDoesNotEqual.h"
#import "./BoolLessThan.h"
#import "./BoolLessThanOrEquals.h"
#import "./BoolGreaterThan.h"
#import "./BoolGreaterThanOrEquals.h"

#import "PrintInt.h"
#import "PrintBool.h"
#import "IntAssignment.h"
#import "BoolAssignment.h"
#import "IntArrayElementAssignment.h"
#import "BoolArrayElementAssignment.h"
#import "IfThenElseEndIf.h"
#import "IfThenEndIf.h"
#import "WhileEndWhile.h"



@interface ComponentViewController ()

@end

@implementation ComponentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void) acceptInt:(int)integer {
    [self.delegate acceptElement:[[IntValue alloc] initWithValue:integer]];
}

- (void) acceptVar:(NSString *)variable {
    if (self.type < 8 || self.type > 11)
        [NSException raise:@"Invalid type value" format:@"value of %ld is invalid", self.type];
    if (self.type == 8 || self.type == 10)
        [self.delegate acceptElement:[[IntVariable alloc] initWithVariable:variable]];
    else
        [self.delegate acceptElement:[[BoolVariable alloc] initWithVariable:variable]];
}

- (NSMutableArray *) getScope {
    return [self.delegate getScope:(self.type == 8 || self.type == 10) ? 4 : 5];
}

NSMutableArray * listOfElements[3];

- (void) initMenus {
    for (int i = 0; i < 3; i++)
        listOfElements[i] = [[NSMutableArray alloc] init];
    if ((self.type >= 2 && self.type <= 7) || self.type < 1 || self.type > 11)
        [NSException raise:@"Invalid type value" format:@"value of %ld is invalid", self.type];
    if (self.type == 1) { // Statement
        [listOfElements[0] addObject:@"IntegerVar = ?"];
        [listOfElements[0] addObject:@"BooleanVar = ?"];
        [listOfElements[0] addObject:@"Integer[?] = ?"];
        [listOfElements[0] addObject:@"Boolean[?] = ?"];
        
        [listOfElements[1] addObject:@"If ? Then _"];
        [listOfElements[1] addObject:@"If ? Then _ Else _"];
        [listOfElements[1] addObject:@"While ? _"];
        
        [listOfElements[2] addObject:@"Print Integer ?"];
        [listOfElements[2] addObject:@"Print Boolean ?"];
    } else if (self.type == 8 || self.type == 10) { // Int Expression
        [listOfElements[1] addObject:@"Integer[?]"];
        [listOfElements[1] addObject:@"RandomInt(?)"];
        [listOfElements[1] addObject:@"-?"];
        [listOfElements[1] addObject:@"? + ?"];
        [listOfElements[1] addObject:@"? - ?"];
        [listOfElements[1] addObject:@"? * ?"];
        [listOfElements[1] addObject:@"? / ?"];
        [listOfElements[1] addObject:@"? % ?"];
    } else if (self.type == 9 || self.type == 11) { // Bool Expression
        [listOfElements[1] addObject:@"? = ?"];
        [listOfElements[1] addObject:@"? ≠ ?"];
        [listOfElements[1] addObject:@"? < ?"];
        [listOfElements[1] addObject:@"? ≤ ?"];
        [listOfElements[1] addObject:@"? > ?"];
        [listOfElements[1] addObject:@"? ≥ ?"];
        
        [listOfElements[2] addObject:@"Boolean[?]"];
        [listOfElements[2] addObject:@"RandomBoolean"];
        [listOfElements[2] addObject:@"¬?"];
        [listOfElements[2] addObject:@"? = ?"];
        [listOfElements[2] addObject:@"? ≠ ?"];
        [listOfElements[2] addObject:@"? ∨ ?"];
        [listOfElements[2] addObject:@"? ↓ ?"];
        [listOfElements[2] addObject:@"? ∧ ?"];
        [listOfElements[2] addObject:@"? ↑ ?"];
        [listOfElements[2] addObject:@"? ⇒ ?"];
        [listOfElements[2] addObject:@"? ⇏ ?"];
        [listOfElements[2] addObject:@"? ⇐ ?"];
        [listOfElements[2] addObject:@"? ⇍ ?"];
    } else {
        [NSException raise:@"Invalid type value" format:@"value of %ld is invalid", self.type];
    }
}

- (id <IntExpression>)defaultInt {
    return [[IntValue alloc] initWithValue:0];
}

- (id <BoolExpression>)defaultBool {
    return [[BoolValue alloc] initWithValue:false];
}

- (IntArrayElement *)defaultIntArrayElement {
    return [[IntArrayElement alloc] initWithVariable:[self defaultVar] andIndexExpression:[self defaultInt]];
}

- (BoolArrayElement *)defaultBoolArrayElement {
    return [[BoolArrayElement alloc] initWithVariable:[self defaultVar] andIndexExpression:[self defaultInt]];
}

- (NSString *)defaultVar {
    return [ComponentViewController defaultVar];
}

+ (NSString *)defaultVar {
    return @"x";
}

- (StatementList *)defaultStatementList {
    return [[StatementList alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id element = nil;
    if (self.type == 1) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                element = [[IntAssignment alloc] initWith:[self defaultVar] equals:[self defaultInt]];
            } else if (indexPath.row == 1) {
                element = [[BoolAssignment alloc] initWith:[self defaultVar] equals:[self defaultBool]];
            } else if (indexPath.row == 2) {
                element = [[IntArrayElementAssignment alloc] initWith:[self defaultIntArrayElement] equals:[self defaultInt]];
            } else {
                element = [[BoolArrayElementAssignment alloc] initWith:[self defaultBoolArrayElement] equals:[self defaultBool]];
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                element = [[IfThenEndIf alloc] initWithIf:[self defaultBool] Then:[self defaultStatementList]];
            } else if (indexPath.row == 1) {
                element = [[IfThenElseEndIf alloc] initWithIf:[self defaultBool] Then:[self defaultStatementList] Else:[self defaultStatementList]];
            } else {
                element = [[WhileEndWhile alloc] initWithWhile:[self defaultBool] Do:[self defaultStatementList]];
            }
        } else {
            if (indexPath.row == 0) {
                element = [[PrintInt alloc] initWithExpression:[self defaultInt]];
            } else {
                element = [[PrintBool alloc] initWithExpression:[self defaultBool]];
            }
        }
    } else if (self.type == 8 || self.type == 10) { // Int Expression
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                // Hard code integer
            } else {
                // Variable integer
            }
        } else {
            if (indexPath.row == 0) {
                element = [[IntArrayElement alloc] initWithVariable:[self defaultVar] andIndexExpression:[self defaultInt]];
            } else if (indexPath.row == 1) {
                element = [[IntRandom alloc] initWith:[self defaultInt]];
            } else if (indexPath.row == 2) {
                element = [[IntNegation alloc] initWith:[self defaultInt]];
            } else if (indexPath.row == 3) {
                element = [[IntSum alloc] initWith:[self defaultInt] plus:[self defaultInt]];
            } else if (indexPath.row == 4) {
                element = [[IntDifference alloc] initWith:[self defaultInt] minus:[self defaultInt]];
            } else if (indexPath.row == 5) {
                element = [[IntProduct alloc] initWith:[self defaultInt] times:[self defaultInt]];
            } else if (indexPath.row == 6) {
                element = [[IntQuotient alloc] initWith:[self defaultInt] dividedBy:[self defaultInt]];
            } else {
                element = [[IntRemainder alloc] initWith:[self defaultInt] dividedBy:[self defaultInt]];
            }
        }
    } else if (self.type == 9 || self.type == 11) { // Bool Expression
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                element = [[BoolValue alloc] initWithValue:true];
            } else if (indexPath.row == 1) {
                element = [[BoolValue alloc] initWithValue:false];
            } else {
                // Variable boolean
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                element = [[BoolIntEquals alloc] initWith:[self defaultInt] IntEquals:[self defaultInt]];
            } else if (indexPath.row == 1) {
                element = [[BoolIntDoesNotEqual alloc] initWith:[self defaultInt] IntDoesNotEqual:[self defaultInt]];
            } else if (indexPath.row == 2) {
                element = [[BoolLessThan alloc] initWith:[self defaultInt] LessThan:[self defaultInt]];
            } else if (indexPath.row == 3) {
                element = [[BoolLessThanOrEquals alloc] initWith:[self defaultInt] LessThanOrEquals:[self defaultInt]];
            } else if (indexPath.row == 4) {
                element = [[BoolGreaterThan alloc] initWith:[self defaultInt] GreaterThan:[self defaultInt]];
            } else {
                element = [[BoolGreaterThanOrEquals alloc] initWith:[self defaultInt] GreaterThanOrEquals:[self defaultInt]];
            }
        } else {
            if (indexPath.row == 0) {
                element = [[BoolArrayElement alloc] initWithVariable:[self defaultVar] andIndexExpression:[self defaultInt]];
            } else if (indexPath.row == 1) {
                element = [[BoolRandom alloc] init];
            } else if (indexPath.row == 2) {
                element = [[BoolNegation alloc] initWith:[self defaultBool]];
            } else if (indexPath.row == 3) {
                element = [[BoolBoolEquals alloc] initWith:[self defaultBool] BoolBoolEquals:[self defaultBool]];
            } else if (indexPath.row == 4) {
                element = [[BoolBoolDoesNotEqual alloc] initWith:[self defaultBool] BoolBoolDoesNotEqual:[self defaultBool]];
            } else if (indexPath.row == 5) {
                element = [[BoolOr alloc] initWith:[self defaultBool] BoolOr:[self defaultBool]];
            } else if (indexPath.row == 6) {
                element = [[BoolNor alloc] initWith:[self defaultBool] BoolNor:[self defaultBool]];
            } else if (indexPath.row == 7) {
                element = [[BoolAnd alloc] initWith:[self defaultBool] BoolAnd:[self defaultBool]];
            } else if (indexPath.row == 8) {
                element = [[BoolNand alloc] initWith:[self defaultBool] BoolNand:[self defaultBool]];
            } else if (indexPath.row == 9) {
                element = [[BoolImplies alloc] initWith:[self defaultBool] BoolImplies:[self defaultBool]];
            } else if (indexPath.row == 10) {
                element = [[BoolNonImplies alloc] initWith:[self defaultBool] BoolNonImplies:[self defaultBool]];
            } else if (indexPath.row == 11) {
                element = [[BoolReverseImplies alloc] initWith:[self defaultBool] BoolReverseImplies:[self defaultBool]];
            } else {
                element = [[BoolReverseNonImplies alloc] initWith:[self defaultBool] BoolReverseNonImplies:[self defaultBool]];
            }
        }
    } else {
        [NSException raise:@"Invalid type value" format:@"value of %ld is invalid", self.type];
    }
    if (element != nil)
        [self.delegate acceptElement:element];
}

/*
 
 Returning types
 
 1. Statement
 2. Int Expression
 3. Bool Expression
 4. Int Variable
 5. Bool Variable
 6. Int Array Variable
 7. Bool Array Variable
 8. Int Expression Component
 9. Bool Expression Component
 10. Int Single Component Expression
 11. Bool Single Component Expression
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.settings setSettingsForTableView:self.tableView];
    [self initMenus];
    
    self.navigationItem.leftBarButtonItem = [self.settings getBackArrowWithReceiver:self];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)popQuick {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (self.type == 1) ? 3 : ((self.type == 8 || self.type == 10) ? 2 : 3);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    if (self.type > 1) { // Expressions
        if (0 == (int) section) { // Literal expressions
            if (self.type == 8 || self.type == 10) { // Int expression
                numberOfRows += 2; // Hardcode Menu + Variable Menu
            } else if (self.type == 9 || self.type == 11) { // Bool expression
                numberOfRows += 3; // Hardcode T & F + Variable Menu
            }
        } else { // Formulaic expressions
            numberOfRows += listOfElements[section].count;
        }
    } else { // Statements
        numberOfRows += listOfElements[section].count;
    }
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"";
    NSString * title = @"";
    if (self.type > 1) { // Expressions
        if (0 == (int) indexPath.section) { // Literal expressions
            if (self.type == 8 || self.type == 10) { // Int expression
                if (0 == (int) indexPath.row) {
                    identifier = @"HardcodeIntTypeCell";
                    title = @"Hardcode Integer";
                } else {
                    identifier = @"VariableTypeCell";
                    title = @"Variable Integer";
                }
            } else if (self.type == 9 || self.type == 11) { // Bool expression
                if (0 == (int) indexPath.row) {
                    identifier = @"ComponentTypeCell";
                    title = @"true";
                } else if (1 == (int) indexPath.row) {
                    identifier = @"ComponentTypeCell";
                    title = @"false";
                } else {
                    identifier = @"VariableTypeCell";
                    title = @"Variable Boolean";
                }
            }
        } else { // Formulaic expressions
            identifier = @"ComponentTypeCell";
            title = listOfElements[indexPath.section][indexPath.row];
        }
    } else { // Statements
        identifier = @"ComponentTypeCell";
        title = listOfElements[indexPath.section][indexPath.row];
    }
    if ([identifier isEqualToString:@""] || [title isEqualToString:@""])
        [NSException raise:@"Invalid type value" format:@"value of '%@' or '%@' is invalid", identifier, title];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [[cell textLabel] setText:title];
    [self.settings setSettingsForCell:cell];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * returnValue = @"";
    if (section == 0) {
        if (self.type == 1)
            returnValue = @"Assignment";
        else if (self.type == 8 || self.type == 10)
            returnValue = @"Integer Literals";
        else
            returnValue = @"Boolean Literals";
    } else if (section == 1) {
        if (self.type == 1)
            returnValue = @"Control";
        else
            returnValue = @"Integer Operators";
    } else if (section == 2) {
        if (self.type == 1)
            returnValue = @"Output";
        else
            returnValue = @"Boolean Operators";
    }
    if ([returnValue isEqualToString:@""])
        [NSException raise:@"Invalid type value" format:@"value of '%@' is invalid", returnValue];
    return returnValue;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ComponentToComponent"]) {
        // To be removed
    } else if ([[segue identifier] isEqualToString:@"ComponentToVariable"]) {
        VariableViewController * variableViewController = [segue destinationViewController];
        variableViewController.delegate = self;
        variableViewController.settings = self.settings;
        variableViewController.initialValue = self.currentValueIfApplicable;
    } else if ([[segue identifier] isEqualToString:@"ComponentToHardcodeInt"]) {
        HardcodeIntViewController * hardcodeIntViewController = [segue destinationViewController];
        hardcodeIntViewController.delegate = self;
        hardcodeIntViewController.settings = self.settings;
        hardcodeIntViewController.initialValue = self.currentValueIfApplicable;
    }
}


@end
