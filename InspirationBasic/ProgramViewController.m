//
//  TableViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ProgramViewController.h"
#import "StatementFlatteningVisitor.h"
#import "StatementDeleteVisitor.h"
#import "StatementMoveVisitor.h"
#import "StatementAndDisplayString.h"

//#import "../InspirationBasicTests/StatementDebugStringVisitor.h"
//#import "../InspirationBasicTests/ExpressionDebugStringVisitor.h"
#import "StatementDebugStringVisitor.h"
#import "ExpressionDebugStringVisitor.h"

// Remove later
#import "StatementList.h"
#import "PrintInt.h"
#import "IntAssignment.h"
#import "BoolAssignment.h"
#import "IntArrayElementAssignment.h"
#import "BoolArrayElementAssignment.h"
#import "IfThenElseEndIf.h"
#import "IfThenEndIf.h"
#import "WhileEndWhile.h"

#import "./BoolVariable.h"
#import "./IntVariable.h"
#import "./BoolArrayElement.h"
#import "./IntArrayElement.h"
#import "./IntValue.h"
#import "./BoolValue.h"
#import "./IntNegation.h"
#import "./IntSum.h"
#import "./IntDifference.h"
#import "./IntProduct.h"
#import "./IntQuotient.h"
#import "./IntRemainder.h"
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

#import "OutputViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface ProgramViewController ()

@end

@implementation ProgramViewController

- (void) postOutput:(NSString *)string {
    self.output = [self.output stringByAppendingString:string];
}

- (void) initStatements {
    
    self.statementHasStatementListVisitor = [[StatementHasStatementListVisitor alloc] init];

    self.output = @""; // temporary
    
    self.program = [[Program alloc] initWithTitle:@"Default Program"];
    
    
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:5]]];
    StatementList * loopStatements = [[StatementList alloc] init];
    BoolLessThan * lessThan = [[BoolLessThan alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] LessThan:[[IntValue alloc] initWithValue:10]];
    IntSum * sum = [[IntSum alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] plus:[[IntValue alloc] initWithValue:1]];
    [loopStatements addStatement:[[IntAssignment alloc] initWith:@"x" equals:sum]];
    [loopStatements addStatement:[[PrintInt alloc] initWithExpression:[[IntVariable alloc] initWithVariable:@"x"]]];
    WhileEndWhile * whileEndWhile = [[WhileEndWhile alloc] initWithWhile:lessThan Do:loopStatements];
    [self.program addStatement:whileEndWhile];
    
    StatementList * loopStatements1 = [[StatementList alloc] init];
    BoolLessThan * lessThan1 = [[BoolLessThan alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] LessThan:[[IntValue alloc] initWithValue:10]];
    IntSum * sum1 = [[IntSum alloc] initWith:[[IntVariable alloc] initWithVariable:@"x"] plus:[[IntValue alloc] initWithValue:1]];
    [loopStatements1 addStatement:[[IntAssignment alloc] initWith:@"x" equals:sum1]];
    [loopStatements1 addStatement:[[PrintInt alloc] initWithExpression:[[IntVariable alloc] initWithVariable:@"x"]]];
    WhileEndWhile * whileEndWhile1 = [[WhileEndWhile alloc] initWithWhile:lessThan1 Do:loopStatements1];
    [whileEndWhile.loopStatements addStatement:whileEndWhile1];
    
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:6]]];
    NSInteger num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:7]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:8]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:9]]];
    num = self.program.statementList.count;
    [self.program addStatement:[[IntAssignment alloc] initWith:@"x" equals:[[IntValue alloc] initWithValue:10]]];
    num = self.program.statementList.count;
    [self reflattenProgram];
}

- (void) reload {
    [self reflattenProgram];
    [self.tableView reloadData];
    [self logProgram];
}

- (void) logProgram {
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [self.program accept:visitor];
    NSLog(@"\n%@",visitor.displayString);
}

- (void) acceptElement:(id)element {
    id <Statement> statement = ((StatementAndDisplayString *)(self.flattenedList[[self.tableView indexPathForSelectedRow].row])).statement;
    StatementList * list = ((StatementList *) statement.parent);
    NSUInteger index = [list.statementList indexOfObject:statement];
    [list.statementList removeObjectAtIndex:index];
    [list.statementList insertObject:element atIndex:index];
    ((id <Statement>) element).parent = list;
    [self reload];
    NSUInteger newIndex = (NSInteger) [self getFlattenedIndexForStatement:element];
    NSUInteger newSection = 0;
    const NSUInteger pathIndecies[] = {newSection, newIndex};
    NSIndexPath * path = [[NSIndexPath alloc] initWithIndexes:pathIndecies length:2];
    [self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionMiddle];
    [self.navigationController popToViewController:self animated:false];
    [self performSegueWithIdentifier:@"ProgramToElement" sender:self];
    
}

- (int) getFlattenedIndexForStatement:(id <Statement>)statement {
    for (int i = 0; i < self.flattenedList.count; i++)
        if (((StatementAndDisplayString *)self.flattenedList[i]).statement == statement)
            return i;
    return -1;
}

- (IBAction)deleteAll:(UIButton *)sender {
    [self deleteStatement:(UIButton *)sender and:false];
}

- (IBAction)deleteProtectChildren:(UIButton *)sender {
    [self deleteStatement:(UIButton *)sender and:true];
}

- (void)deleteStatement:(UIButton *)sender and:(bool)protectChildren {
    UITableViewCell * cell = (UITableViewCell *) [[[sender superview] superview] superview];
    
    [self setButtonsOnCell:cell to:false];
    
    UITableView * table = (UITableView *)[[cell superview] superview];
    NSInteger index = [[table indexPathForCell:cell] row];
    id <Statement> statement = ((StatementAndDisplayString *) self.flattenedList[index]).statement;
    StatementDeleteVisitor * visitor = [[StatementDeleteVisitor alloc] initWithStatement:statement and:protectChildren];
    [visitor deleteStatement];
    float verticalContentOffset = table.contentOffset.y;
    [self reload];
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell * newCell = [table cellForRowAtIndexPath:newIndexPath];
    NSInteger newIndex = index;
    if (newCell == nil) {
        newIndex = [table numberOfRowsInSection:0] - 1;
        newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
        newCell = [table cellForRowAtIndexPath:newIndexPath];
    }
    verticalContentOffset = verticalContentOffset + (table.rowHeight) * (newIndex - index);
    [table setContentOffset:CGPointMake(0, verticalContentOffset)];
    [table selectRowAtIndexPath:newIndexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    [self setButtonsOnCell:newCell to:true];
    
}

- (IBAction)insertAfter:(UIButton *)sender {
}

- (void) reflattenProgram {
    
    // Determine flattened statement list
    StatementFlatteningVisitor * visitor = [[StatementFlatteningVisitor alloc] init];
    self.flattenedList = [visitor getFlattenedList:self.program];
}

- (void) moveUp:(bool)up withSender:(UIButton *)sender {
    
    SystemSoundID soundFileObject;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
                                                withExtension: @"aif"];
    CFURLRef soundFileURLRef = (__bridge CFURLRef) tapSound;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundFileObject);
    AudioServicesPlaySystemSound(soundFileObject);
    AudioServicesDisposeSystemSoundID(soundFileObject);
    
    UITableViewCell * cell = (UITableViewCell *) [[[sender superview] superview] superview];
    
    [self setButtonsOnCell:cell to:false];
    
    UITableView * table = (UITableView *)[[cell superview] superview];
    NSInteger index = [[table indexPathForCell:cell] row];
    id <Statement> statement = ((StatementAndDisplayString *) self.flattenedList[index]).statement;
    StatementMoveVisitor * visitor = [[StatementMoveVisitor alloc] initWithDirection:up andStatement:statement];
    [visitor move];
    [self reload];
    //need index from flattened statements where the statement is equal to this statement
    NSInteger newIndex = [StatementAndDisplayString indexOfStatement:statement inList:self.flattenedList];
    //NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
    
    //NSArray * indexPaths = [[NSArray alloc] initWithObjects:indexPath, newIndexPath, nil];
    
    
    
    float oldOffset = table.contentOffset.y;
    //[table selectRowAtIndexPath:newIndexPath animated:false scrollPosition:UITableViewScrollPositionMiddle];
    //if (oldOffset != table.contentOffset.y) {
        float verticalContentOffset = oldOffset + (table.rowHeight) * (newIndex - index);
    float top = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        if (verticalContentOffset < 0 - top)
            verticalContentOffset = 0 - top;
        [table setContentOffset:CGPointMake(0, verticalContentOffset)];
    //}
    
    [table selectRowAtIndexPath:newIndexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    
    [self setButtonsOnCell:[table cellForRowAtIndexPath:newIndexPath] to:true];
    // Commented out since we can move statement groups
    //[table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)moveUp:(UIButton *)sender {
    [self moveUp:true withSender:sender];
}

- (IBAction)moveDown:(UIButton *)sender {
    [self moveUp:false withSender:sender];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self initStatements];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initStatements];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.flattenedList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatementCell" forIndexPath:indexPath];
    
    // Configure the cell...
    StatementAndDisplayString * statementAndString = (StatementAndDisplayString *) self.flattenedList[indexPath.row];
    NSString * string = statementAndString.displayString;
    [[cell textLabel] setText:string];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Chalkduster" size:18.0]];
    [[cell textLabel] setFont:[UIFont fontWithName:@"Courier" size:18.0]];
    NSArray * families = [UIFont familyNames];
    NSString * family;
    for (family in families) {
        NSString * font;
        //NSLog(@"%@",family);
        for (font in families) {
            //NSLog(@"%@",font);
        }
    }
     
    //NSLog(@"%@",[UIFont fontWithName:@"Chalkduster" size:36.0]);
    [self setButtonsOnCell:cell to:false];
    ((UIButton *) [cell.contentView viewWithTag:1]).hidden = ![self.statementHasStatementListVisitor hasStatementList:statementAndString.statement];
    return cell;
}

- (void) setButtonsOnCell:(UITableViewCell *)cell to:(bool)enabled {
    //id <Statement> statement = ((StatementAndDisplayString *) self.flattenedList[[[(UITableView *)[[cell superview] superview] indexPathForCell:cell] row]]).statement;
    //bool hasChildren = [self.statementHasStatementListVisitor hasStatementList:statement];
    for (int i = 1; i < 7; i++) {
        [((UIButton *) [cell.contentView viewWithTag:i]) setEnabled:enabled];//(hasChildren ? enabled : false)];
    }
    //int i = [[(UITableView *)[[cell superview] superview] indexPathForCell:cell] row];
    //((UIButton *) [cell.contentView viewWithTag:1]).hidden = !hasChildren;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setButtonsOnCell:[tableView cellForRowAtIndexPath:indexPath] to:true];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setButtonsOnCell:[tableView cellForRowAtIndexPath:indexPath] to:false];
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
    if ([[segue identifier] isEqualToString:@"ProgramToElement"]) {
        id <Statement> statement = ((StatementAndDisplayString *)(self.flattenedList[[self.tableView indexPathForSelectedRow].row])).statement;
        ElementViewController * statementViewController = [segue destinationViewController];
        statementViewController.element = statement;
        statementViewController.type = 1;
        statementViewController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"ProgramToComponent"]) {
        
    } else if ([[segue identifier] isEqualToString:@"ProgramToOutput"]) {
        [self.program executeWithListener:self];
        OutputViewController * outputViewController = [segue destinationViewController];
        outputViewController.outputText = self.output;
    }
}


@end
