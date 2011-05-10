//
//  RootViewController.h
//  Youtube
//
//  Created by boris charpentier on 08/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

	NSMutableData *receivedData;
	NSArray *youtubeArray;
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
-(IBAction)edit;

@end
