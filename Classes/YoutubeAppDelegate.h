//
//  YoutubeAppDelegate.h
//  Youtube
//
//  Created by boris charpentier on 08/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YoutubeAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


- (NSURL *)applicationDocumentsDirectory;

@end

