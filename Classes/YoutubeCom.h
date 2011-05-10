//
//  YoutubeCom.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YoutubeCom : NSObject {
	NSString *content;
	NSString *title;
	NSString *author;
}

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;

@end

