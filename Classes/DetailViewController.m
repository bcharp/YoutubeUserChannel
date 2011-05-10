//
//  detailViewController.m
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import "DetailViewController.h"
#import "JSONKit.h"
#import "YoutubeCom.h"
#import "YoutubeConnection.h"

@implementation DetailViewController

@synthesize ye;

- (void)viewDidLoad {
    [super viewDidLoad];
	table.delegate = self;
	table.dataSource = self;
	table.rowHeight = 120;
	youtubeArray = [[NSArray alloc] init];
	[self embedYouTube:ye.videoPath];
	self.title = ye.title;
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&alt=json",ye.commentPath]];
	YoutubeConnection *con = [[YoutubeConnection alloc] init];
	[con launchWithCommentUrl:url andBlock:^(NSArray *array){
		youtubeArray = array;
		[table reloadData];
	}];
}


- (void)embedYouTube:(NSString*)url{  
	CGRect frame = webView.frame;
 NSString* embedHTML = @"\ <html><head>\ <style type=\"text/css\">\ body {\ background-color: transparent;\ color: white;\ }\ </style>\ </head><body style=\"margin:0\">\ <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \ width=\"%0.0f\" height=\"%0.0f\"></embed>\ </body></html>";  
 NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  
  
 [webView loadHTMLString:html baseURL:nil];  
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
	cell.textLabel.text = [[youtubeArray objectAtIndex:indexPath.row] author];
	cell.detailTextLabel.text = [[youtubeArray objectAtIndex:indexPath.row] content];
	cell.detailTextLabel.numberOfLines = 4;
	cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;

}

#pragma mark -
#pragma mark memory mgmt

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[ye release], ye = nil;

    [super dealloc];
}


@end

