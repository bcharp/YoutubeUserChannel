//
//  detailViewController.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeEntry.h"

@interface DetailViewController : UIViewController <UITableViewDelegate>{
	IBOutlet UIWebView *webView;
	IBOutlet UITableView *table;
	NSMutableData *receivedData;
	NSArray *youtubeArray;
	YoutubeEntry *ye;
}

@property (nonatomic, retain) YoutubeEntry *ye;
- (void)embedYouTube:(NSString*)url;

@end

