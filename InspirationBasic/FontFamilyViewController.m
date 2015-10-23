//
//  FontFamilyViewController.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/3/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "FontFamilyViewController.h"

@interface FontFamilyViewController ()

@end

@implementation FontFamilyViewController

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
    self.fonts = [[UIFont familyNames] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
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
    return self.fonts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyCell" forIndexPath:indexPath];
    [[cell textLabel] setText:self.fonts[indexPath.row]];
    [self.settings setSettingsForCell:cell];
    NSArray * fonts = [UIFont fontNamesForFamilyName:self.fonts[indexPath.row]];
    [[cell textLabel] setFont:[UIFont fontWithName:fonts[0] size:15.0]];
    //[[cell textLabel] setFont:[UIFont [UIFont familyNames][indexPath.row]][0]];
    //[[cell textLabel] setFont:[UIFont fontWithName:fonts[indexPath.row] size:15.0]];
    return cell;
}

- (void) acceptFont:(NSString *)font {
    [self.delegate acceptFont:font];
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
    long index = [self.tableView indexPathForSelectedRow].row;
    if ([[segue identifier] isEqualToString:@"FamilyToFont"]) {
        FontViewController * fontViewController = [segue destinationViewController];
        fontViewController.fonts = [UIFont fontNamesForFamilyName:self.fonts[index]];
        fontViewController.delegate = self;
        fontViewController.settings = self.settings;
        
    }
}


@end
