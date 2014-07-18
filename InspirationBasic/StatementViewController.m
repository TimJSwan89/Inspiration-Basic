//
//  StatementViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "StatementViewController.h"
#import "StatementComponentViewController.h"
#import "IntExpressionViewController.h"
#import "BoolExpressionViewController.h"

#import "StatementBreakdownVisitor.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initCellModels {
    StatementBreakdownVisitor * visitor = [[StatementBreakdownVisitor alloc] init];
    [visitor generateBreakdown:self.statement];
    self.types = visitor.types;
    self.elements = visitor.elements;
    self.strings = visitor.strings;
    
    self.typesIndex = [[NSMutableArray alloc] init];
    [self.typesIndex addObject:@"Dummy"];
    [self.typesIndex addObject:@"StatementComponentCell"];
    [self.typesIndex addObject:@"IntExpressionCell"];
    [self.typesIndex addObject:@"BoolExpressionCell"];
    [self.typesIndex addObject:@"IntVariableCell"];
    [self.typesIndex addObject:@"BoolVariableCell"];
    [self.typesIndex addObject:@"IntArrayVariableCell"];
    [self.typesIndex addObject:@"BoolArrayVariableCell"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCellModels];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"StatementToComponent"]) {
        StatementComponentViewController * statementComponentViewController = [segue destinationViewController];
        statementComponentViewController.statement = self.statement;
    } else if ([[segue identifier] isEqualToString:@"StatementToInt"]) {
        id <IntExpression> intExpression = self.elements[[self.tableView indexPathForSelectedRow].row];
        IntExpressionViewController * intExpressionViewController = [segue destinationViewController];
        intExpressionViewController.intExpression = intExpression;
    } else if ([[segue identifier] isEqualToString:@"StatementToBool"]) {
        id <BoolExpression> boolExpression = self.elements[[self.tableView indexPathForSelectedRow].row];
        BoolExpressionViewController * boolExpressionViewController = [segue destinationViewController];
        boolExpressionViewController.boolExpression = boolExpression;
    }
}


@end
