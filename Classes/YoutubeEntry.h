//
//  YoutubeEntry.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 id,
    "media$group",
    link,
    category,
    title,
    "yt$statistics",
    published,
    "yt$accessControl",
    "gd$comments",
    "yt$rating",
    updated,
    author,
    "gd$rating",
    "gd$etag",
    content
 */

@interface YoutubeEntry : NSObject {

	NSString *title;
	NSString *videoPath;
	NSString *thumbnailsPath;
	NSString *commentPath;
	NSInteger *commentCount;
	
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, copy) NSString *thumbnailsPath;
@property (nonatomic, copy) NSString *commentPath;
@property (nonatomic, assign) NSInteger *commentCount;

@end

