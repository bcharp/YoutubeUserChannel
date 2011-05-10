//
//  BCURLConnection.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BCURLConnection : NSURLConnection {
	NSInteger *tag;
}

@property(copy) void (^block)(NSArray *);

@property (nonatomic, assign) NSInteger *tag;

@end


