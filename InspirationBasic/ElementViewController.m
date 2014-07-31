//
//  StatementViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ElementViewController.h"
#import "VariableViewController.h"
#import "StatementBreakdownVisitor.h"
#import "ExpressionBreakdownVisitor.h"
#import "ExpressionReplaceChildVisitor.h"
#import "StatementReplaceChildVisitor.h"
#import "ExpressionIsLeafVisitor.h"
#import "StatementFindOrReplaceVariables.h"

@interface ElementViewController ()

@end

@implementation ElementViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initCellModels {
    if (self.type == 1) {
        StatementBreakdownVisitor * visitor = [[StatementBreakdownVisitor alloc] init];
        [visitor generateBreakdown:self.element];
        self.types = visitor.types;
        self.elements = visitor.elements;
        self.strings = visitor.strings;
    } else {
        ExpressionBreakdownVisitor * visitor = [[ExpressionBreakdownVisitor alloc] init];
        if (self.type == 2)
            [visitor generateBreakdownInt:self.element];
        else if (self.type == 3)
            [visitor generateBreakdownBool:self.element];
        else
            [NSException raise:@"Invalid type value" format:@"value of %d is invalid", self.type];
        self.types = visitor.types;
        self.elements = visitor.elements;
        self.strings = visitor.strings;
    }
}

- (void)initTypesIndex {
    self.typesIndex = [[NSMutableArray alloc] init];
    [self.typesIndex addObject:@"Dummy"];               // 0
    [self.typesIndex addObject:@"ComponentCell"];       // 1
    [self.typesIndex addObject:@"ExpressionCell"];      // 2
    [self.typesIndex addObject:@"ExpressionCell"];      // 3
    [self.typesIndex addObject:@"VariableCell"];        // 4
    [self.typesIndex addObject:@"VariableCell"];        // 5
    [self.typesIndex addObject:@"VariableCell"];        // 6
    [self.typesIndex addObject:@"VariableCell"];        // 7
    [self.typesIndex addObject:@"ComponentCell"];       // 8
    [self.typesIndex addObject:@"ComponentCell"];       // 9
    [self.typesIndex addObject:@"ComponentCell"];       // 10
    [self.typesIndex addObject:@"ComponentCell"];       // 11
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
}

- (NSMutableArray *) getScope {
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    int index = path.row;
    int wasType = [self.types[index] intValue];
    if (wasType < 4 || wasType > 7)
        [NSException raise:@"Invalid type value" format:@"value of %d is invalid", wasType];
    return [self.delegate getScope:wasType];
}

- (NSMutableArray *) getScope:(int)type {
    return [self.delegate getScope:type];
}

- (void) acceptVar:(NSString *)variable {
    if (self.type != 1)
        [NSException raise:@"Invalid type value" format:@"value of %d is invalid", self.type];
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    StatementFindOrReplaceVariables * visitor = [[StatementFindOrReplaceVariables alloc] init];
    [visitor replaceVariable:(id <Statement>) self.element withVariable:variable];
    [self reload];
    [self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionNone];
    [self.navigationController popToViewController:self animated:true];
}

- (void) acceptElement:(id) element {
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    int index = path.row;
    int wasType = [self.types[index] intValue];
    if (wasType == 2 || wasType == 3 || wasType == 10 || wasType == 11) { // Was a literal or expression
        ExpressionIsLeafVisitor * leafVisitor = [[ExpressionIsLeafVisitor alloc] init];
        bool shouldPop;
        if (wasType == 2 || wasType == 10) {
            shouldPop = [leafVisitor checkIfIntLeaf:element];
        } else {
            shouldPop = [leafVisitor checkIfBoolLeaf:element];
        }
        if (self.type == 1) {
            StatementReplaceChildVisitor * visitor = [[StatementReplaceChildVisitor alloc] init];
            [visitor replaceChild:self.elements[index] OfStatement:self.element With:element];
        } else if ((self.type == 2) || (self.type == 3)) {
            ExpressionReplaceChildVisitor * visitor = [[ExpressionReplaceChildVisitor alloc] init];
            if (self.type == 2) {
                [visitor replaceChild:self.elements[index] OfIntExpression:self.element With:element];
            } else {
                [visitor replaceChild:self.elements[index] OfBoolExpression:self.element With:element];
            }
        } else {
            [NSException raise:@"Invalid type value" format:@"value of %d is invalid", self.type];
        }
        [self reload];
        [self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionNone];
        [self.navigationController popToViewController:self animated:shouldPop];
        if (!shouldPop) {
            [self performSegueWithIdentifier:[self getElementToElementSegueIdentifier] sender:self];
        }
    } else {
        [self.delegate acceptElement:element];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.settings setSettingsForTableView:self.tableView];
    [self initCellModels];
    [self initTypesIndex];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) reload {
    [self initCellModels];
    [self.tableView reloadData];
    [self.delegate reload];
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
    return self.types.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)self.typesIndex[[((NSNumber *)self.types[indexPath.row]) intValue]] forIndexPath:indexPath];
    [[cell textLabel] setText:self.strings[indexPath.row]];
    [self.settings setSettingsForCell:cell];
    return cell;
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
- (NSString *) getElementToElementSegueIdentifier {
    return @"ElementToElement";
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int index = [self.tableView indexPathForSelectedRow].row;
    id nextElement = self.elements[index];
    int nextType = [self.types[index] integerValue];
    if (nextType < 1 || nextType > 11)
        [NSException raise:@"Invalid type value" format:@"value of %d is invalid", nextType];
    if ([[segue identifier] isEqualToString:@"ElementToComponent"]) {
        ComponentViewController * componentViewController = [segue destinationViewController];
        componentViewController.type = nextType;
        componentViewController.delegate = self;
        componentViewController.settings = self.settings;
    } else if ([[segue identifier] isEqualToString:[self getElementToElementSegueIdentifier]]) {
        ElementViewController * statementViewController = [segue destinationViewController];
        statementViewController.element = nextElement;
        statementViewController.type = nextType;
        statementViewController.delegate = self;
        statementViewController.settings = self.settings;
    } else if ([[segue identifier] isEqualToString:@"ElementToVariable"]) {
        VariableViewController * variableViewController = [segue destinationViewController];
        variableViewController.delegate = self;
        variableViewController.settings = self.settings;
    }
}


@end
