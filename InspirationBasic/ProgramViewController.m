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
#import "StatementDebugStringVisitor.h"
#import "StatementFindOrReplaceVariables.h"
#import "StatementCell.h"

@interface ProgramViewController ()

@end

@implementation ProgramViewController

- (void) reload {
    [self.delegate save];
    [self reflattenProgram];
    [self checkEmptyState];
    [self.tableView reloadData];
    //[self logProgram];
}

//- (void) logProgram {
//    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
//    [self.program accept:visitor];
//    NSLog(@"\n%@",visitor.displayString);
//}

- (NSMutableArray *) getScope:(int)type {
    StatementFindOrReplaceVariables * visitor = [[StatementFindOrReplaceVariables alloc] init];
    return [visitor findVariables:self.program withType:type];
}

- (void) acceptElement:(id)element {
    long row = [self.tableView indexPathForSelectedRow].row;
    if (self.emptyState) {
        [self.program addStatement:element];
    } else {
        id <Statement> statement = ((StatementAndDisplayString *)(self.flattenedList[row])).statement;
        StatementList * list = ((StatementList *) statement.parent);
        NSUInteger index = [list.statementList indexOfObject:statement];
        if (!self.inserting)
            [list.statementList removeObjectAtIndex:index];
        [list.statementList insertObject:element atIndex:index];
        ((id <Statement>) element).parent = list;
        if (self.inserting)
            [self moveStatement:element Up:false];
    }
    [self reload];
    NSUInteger newIndex = (NSInteger) [self getFlattenedIndexForStatement:element];
    NSUInteger newSection = 0;
    const NSUInteger pathIndecies[] = {newSection, newIndex};
    NSIndexPath * path = [[NSIndexPath alloc] initWithIndexes:pathIndecies length:2];
    [self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionMiddle];
    [self.navigationController popToViewController:self animated:false];
    [self performSegueWithIdentifier:ProgramToElementSegueIdentifier sender:self];
}

- (void) finishedExecuting {
    [self.runButton setTitle:runButtonRunString];
    self.running = false;
    [self.tableView reloadData];
    [self.delegate program:self.program isExecuting:false underVC:self];
}

- (IBAction)Run:(UIBarButtonItem *)sender {
    if (self.running) {
        //[self presentViewController:self.executingViewController animated:true completion:^{}];
        [self.navigationController pushViewController:self.executingViewController animated:false];
    } else if (self.emptyState) {
        [self performSegueWithIdentifier:programToComponentSegueIdentifier sender:self];
    } else { // Run program
        [sender setTitle:@"Output"];
        self.running = true;
        [self.tableView reloadData];
        [self.delegate program:self.program isExecuting:true underVC:self];
        [self performSegueWithIdentifier:programToOutputIdentifier sender:self];
    }
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
    StatementCell * cell = (StatementCell *) [[[sender superview] superview] superview];
    
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
    [self setButtonsOnCell:(StatementCell *)newCell to:true];
    
}

- (IBAction)insertAfter:(UIButton *)sender {
    [self performSegueWithIdentifier:programToComponentSegueIdentifier sender:self];
}

- (void) reflattenProgram {
    StatementFlatteningVisitor * visitor = [[StatementFlatteningVisitor alloc] initWithIndentationString:self.indentString];
    self.flattenedList = [visitor getFlattenedList:self.program];
}

- (void) moveStatement:(id <Statement>)statement Up:(bool)up {
    StatementMoveVisitor * visitor = [[StatementMoveVisitor alloc] initWithDirection:up andStatement:statement];
    [visitor move];
}

- (void) moveCell:(StatementCell *)cell Up:(bool)up {
    [self setButtonsOnCell:cell to:false];
    NSInteger index = [[self.tableView indexPathForCell:cell] row];
    id <Statement> statement = ((StatementAndDisplayString *) self.flattenedList[index]).statement;
    [self moveStatement:statement Up:up];
    [self reload];
    //need index from flattened statements where the statement is equal to this statement
    NSInteger newIndex = [StatementAndDisplayString indexOfStatement:statement inList:self.flattenedList];
    //NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
    
    //NSArray * indexPaths = [[NSArray alloc] initWithObjects:indexPath, newIndexPath, nil];
    
    
    
    float oldOffset = self.tableView.contentOffset.y;
    //[table selectRowAtIndexPath:newIndexPath animated:false scrollPosition:UITableViewScrollPositionMiddle];
    //if (oldOffset != table.contentOffset.y) {
    float verticalContentOffset = oldOffset + (self.tableView.rowHeight) * (newIndex - index);
    float top = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    if (verticalContentOffset < 0 - top)
        verticalContentOffset = 0 - top;
    [self.tableView setContentOffset:CGPointMake(0, verticalContentOffset)];
    //}
    
    [self.tableView selectRowAtIndexPath:newIndexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    
    [self setButtonsOnCell:(StatementCell *)[self.tableView cellForRowAtIndexPath:newIndexPath] to:true];
    // Commented out since we can move statement groups
    //[table reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void) moveUp:(bool)up withSender:(UIButton *)sender {
    StatementCell * cell = (StatementCell *) [[[sender superview] superview] superview];
    [self moveCell:cell Up:up];
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
        //[self initStatements];
    }
    return self;
}

- (void) checkEmptyState {
    self.emptyState = (self.program.statementList.count == 0);
    if (self.emptyState) {
        [self.runButton setTitle:@"Add"];
    } else {
        [self.runButton setTitle:runButtonRunString];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.running = false;
    self.indentString = @"   ";
    [self.settings setSettingsForTableView:self.tableView];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    [self reflattenProgram];
    [self checkEmptyState];
    self.navigationItem.leftBarButtonItem = [self.settings getBackArrowWithReceiver:self];
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)popQuick {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
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
    NSString * identifier;
    NSString * string;
    identifier = @"StatementCell";
    StatementAndDisplayString * statementAndString = (StatementAndDisplayString *) self.flattenedList[indexPath.row];
    StatementHasStatementListVisitor * visitor = [[StatementHasStatementListVisitor alloc] init];
    bool hasXButton = [visitor hasStatementList:statementAndString.statement];
    string = statementAndString.displayString;
    StatementCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [[cell textLabel] setText:string];
    [self.settings setSettingsForCellWithNoSelectionColorAndIndentLines:((StatementCell *) cell) indentString:self.indentString];
    cell.hasXButton = hasXButton;
    [self setButtonsOnCell:cell to:([tableView indexPathForSelectedRow] && ([tableView indexPathForSelectedRow].row == indexPath.row))];
    return cell;
}

- (void) setButtonsOnCell:(StatementCell *)cell to:(bool)enabled {
    if (self.running)
        enabled = false;
    for (int i = 1; i < 7; i++) {
        bool allowed = enabled && (i != 1 || cell.hasXButton);
        UIButton * button = ((UIButton *) [cell.contentView viewWithTag:i]);
        [button setEnabled:allowed];
        [button setAlpha:1.0];
//        if (button.superview == cell)
//            NSLog(@"%@",@"is");
//        else
//            NSLog(@"%@",@"is not");
        [button.superview bringSubviewToFront:button];
        [button setHidden:!allowed];
        //[cell insertSubview:button aboveSubview:cell.contentView];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setButtonsOnCell:(StatementCell *)[tableView cellForRowAtIndexPath:indexPath] to:true];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setButtonsOnCell:(StatementCell *)[tableView cellForRowAtIndexPath:indexPath] to:false];
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
NSString * runButtonRunString = @"Run";
NSString * programToComponentSegueIdentifier = @"ProgramToComponent";
NSString * programToOutputIdentifier = @"ProgramToOutput";
NSString * ProgramToElementSegueIdentifier = @"ProgramToElement";

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:ProgramToElementSegueIdentifier]) {
        id <Statement> statement = ((StatementAndDisplayString *)(self.flattenedList[[self.tableView indexPathForSelectedRow].row])).statement;
        ElementViewController * statementViewController = [segue destinationViewController];
        statementViewController.element = statement;
        statementViewController.type = 1;
        statementViewController.delegate = self;
        statementViewController.settings = self.settings;
        self.inserting = false;
    } else if ([[segue identifier] isEqualToString:programToComponentSegueIdentifier]) {
        ComponentViewController * componentViewController = [segue destinationViewController];
        componentViewController.type = 1;
        componentViewController.delegate = self;
        componentViewController.settings = self.settings;
        self.inserting = true;
    } else if ([[segue identifier] isEqualToString:programToOutputIdentifier]) {
        OutputViewController * outputViewController = [segue destinationViewController];
        outputViewController.program = self.program;
        outputViewController.delegate = self;
        outputViewController.settings = self.settings;
        self.executingViewController = outputViewController;
    }
}


@end
