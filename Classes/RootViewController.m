//
//  RootViewController.m
//  Youtube
//
//  Created by boris charpentier on 08/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import "RootViewController.h"
#import "JSONKit.h"
#import "YoutubeEntry.h"
#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ParameterViewController.h"
#import "YoutubeConnection.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation RootViewController

@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	[[NSUserDefaults standardUserDefaults] setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"username"] forKey:@"username"];
	
	self.tableView.rowHeight = 120;
	NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
	self.title = username;
	youtubeArray = [[NSArray alloc] init];

}
-(void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	NSLog(@"view did appear");
	NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
	self.title = username;
	
	YoutubeConnection *con  = [[YoutubeConnection alloc] init];
	[con launchWithName:username andBlock:^(NSArray *array){
		youtubeArray = array;
		[self.tableView reloadData];
	}];
}

-(IBAction)edit{
	
	ParameterViewController *pvc = [[ParameterViewController alloc] initWithNibName:nil bundle:nil];
	pvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:pvc animated:YES];
	
}

// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [youtubeArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
	YoutubeEntry *y = [youtubeArray objectAtIndex:indexPath.row];
	
    cell.textLabel.text = y.title;
	cell.textLabel.numberOfLines = 6;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	[cell.imageView setImageWithURL:[NSURL URLWithString:y.thumbnailsPath]
                   placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	DetailViewController *dtvc = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
	//NSLog(@"youtube commentPath %@",[[youtubeArray objectAtIndex:indexPath.row] commentPath]);
	dtvc.ye = [youtubeArray objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:dtvc animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [super dealloc];
}


@end

