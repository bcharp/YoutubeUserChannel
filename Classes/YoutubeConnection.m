//
//  YoutubeConnection.m
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import "YoutubeConnection.h"


@implementation YoutubeConnection

@synthesize tag;

@synthesize youtubeArray;


- (void)dealloc
{
	[youtubeArray release], youtubeArray = nil;

	[tag release], tag = nil;

	[super dealloc];
}
-(id) init{
	
	if (self = [super init]) {
		
	}
	return self;
}


-(void)launchWithName:(NSString *)username andBlock:(void (^)(NSArray *obj))block{
	
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?author=%@&v=2&alt=json&orderby=published",username]];
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
	BCURLConnection *con = [[BCURLConnection alloc] initWithRequest:req delegate:self];
	con.tag = 1;
	con.block = block;
	
	if (con) {
		NSLog(@"launch connection");
		receivedData = [[NSMutableData data] retain];
	}
	
}

-(void)launchWithCommentUrl:(NSURL *)url andBlock:(void (^)(NSArray *obj))block{
		NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
	BCURLConnection *con = [[BCURLConnection alloc] initWithRequest:req delegate:self];
	con.tag = 2;
	con.block = block;
	
	if (con) {
		NSLog(@"launch connection");
		receivedData = [[NSMutableData data] retain];
	}

}


- (void)connection:(BCURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(BCURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
	NSLog(@"did finish launching");
	//NSLog(@"------ %i ----",[connection tag]);
	//tag 1 is videos tag 2 is comment
	if (connection.tag == 1) {
		JSONDecoder* dec = [[JSONDecoder alloc] init];
		id toto = [dec objectWithData:receivedData];
		youtubeArray = [[NSMutableArray alloc] initWithCapacity:50];
		for (id *obj in [[toto objectForKey:@"feed"] objectForKey:@"entry"]) {
			YoutubeEntry *ye = [[YoutubeEntry alloc] init];
			NSArray *akeys = [[obj allKeys] retain];
			for (int i=0; i<[akeys count]; i++) {
				if ([[akeys objectAtIndex:i] isEqualToString:@"title"]) {
					ye.title = [[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"$t"];
				}else if ([[akeys objectAtIndex:i] isEqualToString:@"gd$comments"]) {
					ye.commentPath =  [[[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"gd$feedLink"] objectForKey:@"href"];
					ye.commentCount = (NSInteger) [[[[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"gd$feedLink"] objectForKey:@"countHint"] intValue];
				}else if ([[akeys objectAtIndex:i] isEqualToString:@"content"]) {
					ye.videoPath = [[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"src"];
				}else if ([[akeys objectAtIndex:i] isEqualToString:@"media$group"]) {
					ye.thumbnailsPath = [[[[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"media$thumbnail"] objectAtIndex:0] objectForKey:@"url"];
				}
			}
			
			[youtubeArray addObject:ye];
			[ye release];
		}

	}else if(connection.tag == 2 ) {
		
		JSONDecoder* dec = [[JSONDecoder alloc] init];
		id toto = [dec objectWithData:receivedData];
		youtubeArray = [[NSMutableArray alloc] initWithCapacity:50];
		for (id *obj in [[toto objectForKey:@"feed"] objectForKey:@"entry"]) {
			YoutubeCom *com = [[YoutubeCom alloc] init];
			NSArray *akeys = [[obj allKeys] retain];
			//NSLog(@"%@",akeys);
			for (int i=0; i<[akeys count]; i++) 
			{
				//NSLog(@"%@ = %@",[akeys objectAtIndex:i], [obj objectForKey:[akeys objectAtIndex:i]]);
				if ([[akeys objectAtIndex:i] isEqualToString:@"title"]) {
					com.title = [[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"$t"];
				}else if ([[akeys objectAtIndex:i] isEqualToString:@"content"]) {
					com.content = [[obj objectForKey:[akeys objectAtIndex:i]] objectForKey:@"$t"];
				}else if ([[akeys objectAtIndex:i] isEqualToString:@"author"]) {
					com.author = [[[[obj objectForKey:[akeys objectAtIndex:i]] objectAtIndex:0] objectForKey:@"name"] objectForKey:@"$t"];
				}
			}
		
		[youtubeArray addObject:com];
		[com release];
		}
	}
	//NSLog(@"youtube array %@",youtubeArray);
	connection.block(youtubeArray);
    [connection release];
    [receivedData release];
}

@end



