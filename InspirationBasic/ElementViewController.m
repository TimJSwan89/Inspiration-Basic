//
//  StatementViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/1/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "ElementViewController.h"
#import "ComponentViewController.h"

#import "StatementBreakdownVisitor.h"
#import "ExpressionBreakdownVisitor.h"

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
        else
            [visitor generateBreakdownBool:self.element];
        self.types = visitor.types;
        self.elements = visitor.elements;
        self.strings = visitor.strings;
    }
    self.typesIndex = [[NSMutableArray alloc] init];
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
    if ([[segue identifier] isEqualToString:@"ElementToComponent"]) {
        ComponentViewController * statementComponentViewController = [segue destinationViewController];
        statementComponentViewController.statement = self.element;
    } else if ([[segue identifier] isEqualToString:@"ElementToElement"]) {
        int index = [self.tableView indexPathForSelectedRow].row;
        id expression = self.elements[index];
        ElementViewController * statementViewController = [segue destinationViewController];
        statementViewController.element = expression;
        statementViewController.type = [(NSNumber *) self.types[index] intValue];
    } else if ([[segue identifier] isEqualToString:@"ElementToVariable"]) {
        
    }
}


@end
