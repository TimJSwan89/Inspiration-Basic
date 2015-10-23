//
//  SettingsViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "SettingsViewController.h"
#import "FontFamilyViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.settings setSettingsForTableView:self.tableView];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfOptions;
}

int numberOfOptions = 5;
int allFont = 0;
int allTextColor = 2;
int allBackgroundColor = 4;
int textColor = 1;
int headerColor = 3;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier;
    NSString * title;
    if (indexPath.row == allFont) {
        identifier = @"FontCell";
        title = @"Font";
    } else if (indexPath.row == allTextColor) {
        identifier = @"ColorCell";
        title = @"Item Colors";
    } else if (indexPath.row == allBackgroundColor) {
        identifier = @"ColorCell";
        title = @"Background Color";
    } else if (indexPath.row == textColor) {
        identifier = @"ColorCell";
        title = @"Text Color";
    } else if (indexPath.row == headerColor) {
        identifier = @"ColorCell";
        title = @"Header Color";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [[cell textLabel] setText:title];
    [self.settings setSettingsForCell:cell];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        FCColorPickerViewController * colorPicker = [FCColorPickerViewController colorPicker];
        if (indexPath.row == allTextColor) {
            colorPicker.color = self.settings.buttonColor;
        } else if (indexPath.row == allBackgroundColor) {
            colorPicker.color = self.settings.backgroundColor;
        } else if (indexPath.row == textColor) {
            colorPicker.color = self.settings.textColor;
        } else if (indexPath.row == headerColor) {
            colorPicker.color = self.settings.navigationBarForegroundColor;
        }
        colorPicker.delegate = self;
        [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
        //[self.navigationController pushViewController:colorPicker animated:NO];
        [self presentViewController:colorPicker animated:YES completion:nil];
    }
}

- (void) acceptFont:(NSString *)font {
    self.settings.font = [UIFont fontWithName:font size:self.settings.font.pointSize];
    [self reloadViews];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    long row = [self.tableView indexPathForSelectedRow].row;
    if (row == allTextColor) {
        self.settings.navigationBarButtonColor = color;
        self.settings.buttonColor = color;
    } else if (row == allBackgroundColor) {
        self.settings.backgroundColor = color;
        self.settings.textBackgroundColor = color;
        self.settings.navigationBarBackgroundColor = color;
        self.settings.statusBarTextWhite = 0;
    } else if (row == textColor) {
        self.settings.textColor = color;
    } else if (row == headerColor) {
        self.settings.navigationBarForegroundColor = color;
    }
    [self reloadViews];
    //[self.navigationController popToViewController:self animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) reloadViews {
    [self.settings setSettingsForNavigationBarAndStatusBar:self.navigationController];
    [self.settings setSettingsForTableView:self.tableView];
    [self.tableView reloadData];
    [self.delegate resetView];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    //[self.navigationController popToViewController:self animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([[segue identifier] isEqualToString:@"SettingsToFamily"]) {
        FontFamilyViewController * fontFamilyViewController = [segue destinationViewController];
        fontFamilyViewController.delegate = self;
        fontFamilyViewController.settings = self.settings;
    }
}
@end
