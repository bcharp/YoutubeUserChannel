//
//  YoutubeConnection.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeEntry.h"
#import "YoutubeCom.h"
#import "JSONKit.h"
#import "BCURLConnection.h"

@interface YoutubeConnection : NSObject {
	NSMutableData *receivedData;
	NSArray *youtubeArray;
	NSInteger *tag;
}

@property (nonatomic, assign) NSInteger *tag;

@property (nonatomic, copy) NSArray *youtubeArray;


-(void)launchWithName:(NSString *)username;
-(void)launchWithName:(NSString *)username andBlock:(void (^)(NSArray *obj))block;

-(void)launchWithCommentUrl:(NSURL *)url andBlock:(void (^)(NSArray *obj))block;

@end



