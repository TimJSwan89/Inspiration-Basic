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

#import "StatementFindOrReplaceVariables.h"

#import "OutputViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface ProgramViewController ()

@end

@implementation ProgramViewController

- (void) reload {
    [self reflattenProgram];
    [self.tableView reloadData];
  //  [self logProgram];
}
/*
- (void) logProgram {
    StatementDebugStringVisitor * visitor = [[StatementDebugStringVisitor alloc] init];
    [self.program accept:visitor];
    NSLog(@"\n%@",visitor.displayString);
}
*/
- (NSMutableArray *) getScope:(int)type {
    StatementFindOrReplaceVariables * visitor = [[StatementFindOrReplaceVariables alloc] init];
    return [visitor findVariables:self.program withType:type];
}

- (void) acceptElement:(id)element {
    int row = [self.tableView indexPathForSelectedRow].row;
    if (row == self.flattenedList.count) {
        [self.program.statementList addObject:element];
        ((id <Statement>) element).parent = self.program;
    } else {
        id <Statement> statement = ((StatementAndDisplayString *)(self.flattenedList[row])).statement;
        StatementList * list = ((StatementList *) statement.parent);
        NSUInteger index = [list.statementList indexOfObject:statement];
        if (!self.inserting)
            [list.statementList removeObjectAtIndex:index];
        [list.statementList insertObject:element atIndex:index];
        ((id <Statement>) element).parent = list;
    }
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
    [self performSegueWithIdentifier:@"ProgramToComponent" sender:self];
}

- (void) reflattenProgram {
    StatementFlatteningVisitor * visitor = [[StatementFlatteningVisitor alloc] initWithIndentationString:self.indentString];
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
        //[self initStatements];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.indentString = @"   ";
    [self.settings setSettingsForTableView:self.tableView];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self reflattenProgram];
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
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
    return self.flattenedList.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier;
    NSString * string;
    bool show = false;
    if (indexPath.row == self.flattenedList.count) {
        identifier = @"InsertCell";
        string = @"Add Statement";
    } else {
        identifier = @"StatementCell";
        StatementAndDisplayString * statementAndString = (StatementAndDisplayString *) self.flattenedList[indexPath.row];
        StatementHasStatementListVisitor * visitor = [[StatementHasStatementListVisitor alloc] init];
        show = ![visitor hasStatementList:statementAndString.statement];
        string = statementAndString.displayString;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [[cell textLabel] setText:string];
    [self.settings setSettingsForCellWithNoSelectionColorAndIndentLines:cell indentString:self.indentString];
//    NSArray * families = [UIFont familyNames];
//    NSString * family;
//    for (family in families) {
//        NSString * font;
//        //NSLog(@"%@",family);
//        for (font in families) {
//            //NSLog(@"%@",font);
//        }
//    }
    [self setButtonsOnCell:cell to:([tableView indexPathForSelectedRow] && ([tableView indexPathForSelectedRow].row == indexPath.row))];
    if (show)
        [((UIButton *) [cell.contentView viewWithTag:1]) removeFromSuperview];
    return cell;
}

- (void) setButtonsOnCell:(UITableViewCell *)cell to:(bool)enabled {
    for (int i = 1; i < 7; i++) {
        UIButton * button = ((UIButton *) [cell.contentView viewWithTag:i]);
        [button setEnabled:enabled];
        [button setAlpha:1.0];
//        if (button.superview == cell)
//            NSLog(@"%@",@"is");
//        else
//            NSLog(@"%@",@"is not");
        [button.superview bringSubviewToFront:button];
        [button setHidden:!enabled];
        //[cell insertSubview:button aboveSubview:cell.contentView];
    }
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
        statementViewController.settings = self.settings;
        self.inserting = false;
    } else if ([[segue identifier] isEqualToString:@"ProgramToComponent"]) {
        ComponentViewController * componentViewController = [segue destinationViewController];
        componentViewController.type = 1;
        componentViewController.delegate = self;
        componentViewController.settings = self.settings;
        self.inserting = true;
    } else if ([[segue identifier] isEqualToString:@"ProgramToOutput"]) {
        OutputViewController * outputViewController = [segue destinationViewController];
        outputViewController.program = self.program;
        outputViewController.settings = self.settings;
    }
}


@end
