//
//  YoutubeEntry.m
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import "YoutubeEntry.h"


@implementation YoutubeEntry

@synthesize title;
@synthesize videoPath;
@synthesize thumbnailsPath;
@synthesize commentPath;

- (void)dealloc
{
	[title release], title = nil;
	[videoPath release], videoPath = nil;
	[thumbnailsPath release], thumbnailsPath = nil;
	[commentPath release], commentPath = nil;
	[commentCount release], commentCount = nil;

	[super dealloc];
}
@synthesize commentCount;

@end

