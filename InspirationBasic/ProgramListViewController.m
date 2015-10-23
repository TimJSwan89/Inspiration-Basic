//
//  ProgramListViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 6/18/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "AppDelegate.h"
#import "ProgramListViewController.h"
#import "FontFamilyViewController.h"
#import "WrappedProgram.h"
@interface ProgramListViewController ()

@end

@implementation ProgramListViewController

int menuSection = 0;
int programSection = 1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)initializePrograms {
    
    self.wrappedPrograms = [[NSMutableArray alloc] init];
    NSMutableArray * programs = [self.interface loadPrograms];
    for (int i = 0; i < programs.count; i++) {
        WrappedProgram * wrappedProgram = [[WrappedProgram alloc] init];
        wrappedProgram.program = programs[i];
        wrappedProgram.executing = false;
        [self.wrappedPrograms addObject:wrappedProgram];
    }
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
    long index = [self.tableView indexPathForSelectedRow].row;
    WrappedProgram * wrappedProgram = self.wrappedPrograms[index];
    if (wrappedProgram.executing)
        [NSException raise:@"Saving while executing" format:@"Saving while executing"];
    Program * program = wrappedProgram.program;
    [self.interface replaceProgramInDB:program atIndex:index];
}

- (void) program:(Program *)program isExecuting:(bool)flag underVC:(ProgramViewController *)pvc {
    for (int i = 0; i < self.wrappedPrograms.count; i++) {
        WrappedProgram * wrappedProgram = (WrappedProgram *) self.wrappedPrograms[i];
        if (program == wrappedProgram.program) {
            wrappedProgram.executing = flag;
            wrappedProgram.pvc = flag ? pvc : nil;
        }
        [self.tableView reloadData];
        //NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:programSection];
        //UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView setAllowsSelection:YES];
    self.editingState = false;
    self.renamingState = false;
    //self.tableView.gestureRecognizers. cancelsTouchInView = false;
    
    self.settings = [[ViewSettings alloc] initWithFont:[UIFont fontWithName:@"Courier" size:18.0]
                                       backgroundColor:[UIColor blackColor]
                                             textColor:[UIColor cyanColor]
                                   textBackgroundColor:[UIColor blackColor]
                                 positiveFeedbackColor:[UIColor greenColor]
                                 negativeFeedbackColor:[UIColor redColor]
                          navigationBarBackgroundColor:[UIColor blackColor]
                          navigationBarForegroundColor:[UIColor cyanColor]
                              navigationBarButtonColor:[UIColor whiteColor]
                                           buttonColor:[UIColor whiteColor]
                                    statusBarTextWhite:2 /* 0: auto 1: black 2: white */];
    [self.settings setSettingsForTableView:self.tableView];
    [self.settings setSettingsForNavigationBarAndStatusBar:self.navigationController];
    AppDelegate * appDelegate = UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = appDelegate.managedObjectContext;
    self.interface = [[DBInterface alloc] initWithContext:context];
    [self initializePrograms];
    //[self.navigationController ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) resetView {
    [self.settings setSettingsForTableView:self.tableView];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == programSection) ? self.wrappedPrograms.count : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long index = indexPath.row;
    NSString * cellText;
    NSString * identifier;
    UITableViewCell * cell;
    if (indexPath.section == menuSection) {
        if (indexPath.row == 0) {
            identifier = @"InsertCell";
            cellText = @"Create Program";
        } else if (indexPath.row == 1) {
            identifier = @"SettingsCell";
            cellText = @"Settings";
        }
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    } else {
        identifier = @"ProgramCell";
        WrappedProgram * wrappedProgram = self.wrappedPrograms[index];
        Program * program = wrappedProgram.program;
        cellText = program.title;
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        UIActivityIndicatorView * indicator = (UIActivityIndicatorView *) [cell.contentView viewWithTag:1];
        [cell.contentView bringSubviewToFront:indicator];
        if (wrappedProgram.executing) {
            [indicator startAnimating];
        } else {
            [indicator stopAnimating];
        }
    }
    [[cell textLabel] setText:cellText];
    [self.settings setSettingsForCell:cell];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == programSection) {
        WrappedProgram * wrappedProgram = (WrappedProgram *) self.wrappedPrograms[indexPath.row];
        if (wrappedProgram.executing) {
            [self.navigationController pushViewController:wrappedProgram.pvc animated:false];
        } else {
            [self performSegueWithIdentifier:self.renamingState ? segueVariable : segueProgram sender:self];
        }
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == programSection) {
        WrappedProgram * wrappedProgram = self.wrappedPrograms[indexPath.row];
        return !(wrappedProgram.executing);
    }
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.wrappedPrograms removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.interface removeProgramInDBAtIndex:indexPath.row];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)fromIndexPath toProposedIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.section != programSection)
        toIndexPath = [NSIndexPath indexPathForRow:(toIndexPath.section < programSection ? 0 : self.wrappedPrograms.count - 1) inSection:programSection];
    return toIndexPath;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.wrappedPrograms objectAtIndex:fromIndexPath.row];
    [self.wrappedPrograms removeObjectAtIndex:fromIndexPath.row];
    [self.wrappedPrograms insertObject:object atIndex:toIndexPath.row];
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
    if (indexPath.section == programSection) {
        WrappedProgram * wrappedProgram = self.wrappedPrograms[indexPath.row];
        wrappedProgram.program.title = variable;
        [self.interface replaceProgramInDB:wrappedProgram.program atIndex:indexPath.row];
    } else {
        Program * program = [[Program alloc] initWithTitle:variable];
        WrappedProgram * wrappedProgram = [[WrappedProgram alloc] init];
        wrappedProgram.program = program;
        wrappedProgram.executing = false;
        [self.wrappedPrograms addObject:wrappedProgram];
        [self.interface addProgramToDB:program];
    }
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:false];
}

#pragma mark - Navigation
NSString * segueProgram = @"ProgramListToProgram";
NSString * segueVariable = @"ProgramListToVariable";
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:segueProgram]) {
        ProgramViewController * programViewController = [segue destinationViewController];
        WrappedProgram * wrappedProgram = (WrappedProgram *) self.wrappedPrograms[[self.tableView indexPathForSelectedRow].row];
        Program * program = wrappedProgram.program;
        programViewController.delegate = self;
        programViewController.settings = self.settings;
        programViewController.program = program;
        programViewController.navigationItem.title = program.title;
    } else if ([[segue identifier] isEqualToString:segueVariable]) {
        VariableViewController * variableViewController = [segue destinationViewController];
        NSString * title;
        NSString * initialValue;
        NSIndexPath * path = [self.tableView indexPathForSelectedRow];
        if (path.section == programSection) {
            WrappedProgram * wrappedProgram = (WrappedProgram *) self.wrappedPrograms[path.row];
            Program * program = wrappedProgram.program;
            initialValue = program.title;
            title = @"Rename Program";
        } else {
            initialValue = @"";
            title = @"New Program Title";
        }
        variableViewController.initialValue = initialValue;
        variableViewController.delegate = self;
        variableViewController.settings = self.settings;
        variableViewController.navigationItem.title = title;
    } else if ([[segue identifier] isEqualToString:@"ProgramListToSettings"]) {
        SettingsViewController * settingsViewController = [segue destinationViewController];
        settingsViewController.delegate = self;
        settingsViewController.settings = self.settings;
    }
}

@end
