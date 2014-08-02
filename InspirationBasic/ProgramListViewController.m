//
//  ProgramListViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "AppDelegate.h"
#import "ProgramListViewController.h"

@interface ProgramListViewController ()

@end

@implementation ProgramListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)initializePrograms {
    
    self.programs = [self.interface loadPrograms];

}

- (IBAction)renamePrograms:(UIBarButtonItem *)sender {
    self.editButton.enabled = self.renamingState;
    self.renamingState = !self.renamingState;
    if (self.renamingState) {
        [sender setTitle:@"Done"];
    } else {
        [sender setTitle:@"Rename"];
    }
    if (self.editingState)
        [self ToggleEdit:self.editButton];
}

- (IBAction)ToggleEdit:(UIBarButtonItem *)sender {
    self.renameButton.enabled = self.editingState;
    self.editingState = !self.editingState;
    [self.tableView setEditing:self.editingState animated:true];
    if (self.editingState) {
        [sender setTitle:@"Done"];
    } else {
        [sender setTitle:@"Edit"];
    }
    if (self.renamingState)
        [self renamePrograms:self.renameButton];
}

- (void) save {
    int index = [self.tableView indexPathForSelectedRow].row;
    Program * program = (Program *) self.programs[index];
    [self.interface replaceProgramInDB:program atIndex:index];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView setAllowsSelection:YES];
    self.editingState = false;
    self.renamingState = false;
    //self.tableView.gestureRecognizers. cancelsTouchInView = false;
    
    self.settings = [[ViewSettings alloc] initWithFont:[UIFont fontWithName:@"Ariel" size:18.0]
                                       backgroundColor:[UIColor blackColor]
                                             textColor:[UIColor cyanColor]
                                   textBackgroundColor:[UIColor blackColor]
                                 positiveFeedbackColor:[UIColor greenColor]
                                 negativeFeedbackColor:[UIColor redColor]
                          navigationBarBackgroundColor:[UIColor blackColor]
                          navigationBarForegroundColor:[UIColor cyanColor]
                              navigationBarButtonColor:[UIColor whiteColor]
                                           buttonColor:[UIColor whiteColor]
                                    statusBarTextWhite:true];
    [self.settings setSettingsForTableView:self.tableView];
    [self.settings setSettingsForNavigationBarAndStatusBar:self.navigationController];
    AppDelegate * appDelegate = UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = appDelegate.managedObjectContext;
    self.interface = [[DBInterface alloc] initWithContext:context];
    [self initializePrograms];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? self.programs.count : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    NSString * cellText;
    NSString * identifier;
    if (indexPath.section == 1) {
        identifier = @"InsertCell";
        cellText = @"Create Program";
    } else {
        identifier = @"ProgramCell";
        Program * program = (Program *) self.programs[index];
        cellText = program.title;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [[cell textLabel] setText:cellText];
    [self.settings setSettingsForCell:cell];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:self.renamingState ? segueVariable : segueProgram sender:self];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return indexPath.section == 0;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.programs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.interface removeProgramInDBAtIndex:indexPath.row];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)fromIndexPath toProposedIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.section == 1)
        toIndexPath = [NSIndexPath indexPathForRow:self.programs.count - 1 inSection:0];
    return toIndexPath;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.programs objectAtIndex:fromIndexPath.row];
    [self.programs removeObjectAtIndex:fromIndexPath.row];
    [self.programs insertObject:object atIndex:toIndexPath.row];
    [self.interface moveProgramInDBFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (NSMutableArray *) getScope {
    return [[NSMutableArray alloc] init];
}

- (void) acceptVar:(NSString *)variable {
    NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath.section == 0) {
        ((Program *) self.programs[indexPath.row]).title = variable;
        [self.interface replaceProgramInDB:self.programs[indexPath.row] atIndex:indexPath.row];
    } else {
        Program * program = [[Program alloc] initWithTitle:variable];
        [self.programs addObject:program];
        [self.interface addProgramToDB:program];
    }
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:true];
}

#pragma mark - Navigation
NSString * segueProgram = @"ProgramListToProgram";
NSString * segueVariable = @"ProgramListToVariable";
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:segueProgram]) {
        ProgramViewController * programViewController = [segue destinationViewController];
        Program * program = (Program *) self.programs[[self.tableView indexPathForSelectedRow].row];
        programViewController.delegate = self;
        programViewController.settings = self.settings;
        programViewController.program = program;
        programViewController.navigationItem.title = program.title;
    } else if ([[segue identifier] isEqualToString:segueVariable]) {
        VariableViewController * variableViewController = [segue destinationViewController];
        variableViewController.delegate = self;
        variableViewController.settings = self.settings;
        variableViewController.navigationItem.title = @"New Program Title";
    }
}

@end
