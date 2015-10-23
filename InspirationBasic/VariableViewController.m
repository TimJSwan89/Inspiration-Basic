//
//  VariableViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 7/20/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "VariableViewController.h"

@interface VariableViewController ()

@end

@implementation VariableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void) initViewModel {
    self.variables = [self.delegate getScope];
    self.button = nil;
    self.textField = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.settings setSettingsForTableView:self.tableView];
    [self initViewModel];
    
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : self.variables.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:(indexPath.section == 0) ? @"NewVariableCell" : @"ExistingVariableCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIView * view = cell.contentView;
        self.textField = (UITextField *) view.subviews[0];
        [self.textField setText:self.initialValue];
        [self.textField becomeFirstResponder];
        [self.settings setSettingsForTextField:self.textField];
        self.button = (UIButton *) view.subviews[1];
        [self.button setEnabled:false];
        [self.settings setSettingsForButton:self.button];
        [self edited:self.textField];
        if (!self.button.enabled)
            [self.textField setText:@""];
    } else {
        [[cell textLabel] setText:self.variables[indexPath.row]];
    }
    [self.settings setSettingsForCell:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        [self.delegate acceptVar:self.variables[indexPath.row]];
    } else {
        UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath: indexPath];
        UITextField *textField = [[cellSelected.contentView subviews] objectAtIndex: 0];
        [textField becomeFirstResponder];
        
        [tableView deselectRowAtIndexPath: indexPath animated: NO];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edited:(UITextField *)sender {
    NSString * string = self.textField.text;
    int value = [string intValue];
    NSString * intString = [NSString stringWithFormat:@"%d", value];
    bool qualifiedVariable = ![string isEqualToString:intString];
    if ([string isEqualToString:@""])
        qualifiedVariable = false;
    [self.button setEnabled:qualifiedVariable];
    [self.settings setFeedbackForTextField:sender to:qualifiedVariable];
}

- (IBAction)pressedUse:(UIButton *)sender {
    [self.delegate acceptVar:self.textField.text];
}
@end
