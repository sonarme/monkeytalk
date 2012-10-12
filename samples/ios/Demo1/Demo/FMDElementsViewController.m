//
//  FMDElementsViewController.m
//  Demo
//
//  Created by Kyle Balogh on 1/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FMDElementsViewController.h"
#import "FMDDetailsViewController.h"
#import "FMDElement.h"


@implementation FMDElementsViewController

@synthesize elementsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* dataPlist = [bundlePath 
                           stringByAppendingPathComponent:@"Data.plist"];
    NSDictionary* plistDictionary = [NSDictionary 
                                     dictionaryWithContentsOfFile:dataPlist];
    
    elementsArray = [plistDictionary objectForKey:@"Elements"];
    [elementsArray retain];
    
    //start of UIButton on nav bar
    
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
    [infoButton addTarget:self action:@selector(helpButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *helpButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    helpButtonItem.accessibilityLabel = @"help";
    
    self.navigationItem.rightBarButtonItem = helpButtonItem;
    
    self.navigationController.navigationBar.tintColor = nil;
    
    [helpButtonItem release];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [elementsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] 
                autorelease];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[elementsArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    FMDDetailsViewController *detailsController = [[FMDDetailsViewController alloc] initWithNibName:@"FMDDetailsViewController" bundle:[NSBundle mainBundle]];
    FMDElement *element = [[FMDElement alloc] init];
    element.atomicNumber = [NSString stringWithFormat:@"%i",indexPath.row+1];
    element.elementSymbol = [[elementsArray objectAtIndex:indexPath.row] objectForKey:@"Symbol"];
    element.elementName = [[elementsArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    detailsController.element = element;
    
    
    [self.navigationController pushViewController:detailsController animated:YES];
}


- (IBAction)helpButtonItem:(id)sender{
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Hierarchy" message:@"MonkeyTalk can automate UITables, UITableViewCells, scrolling, and table navigation." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show];
}

@end
