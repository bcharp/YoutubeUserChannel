//
//  YoutubeCom.m
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import "YoutubeCom.h"


@implementation YoutubeCom

@synthesize content;
@synthesize title;

- (void)dealloc
{
	[content release], content = nil;
	[title release], title = nil;
	[author release], author = nil;

	[super dealloc];
}
@synthesize author;

@end

