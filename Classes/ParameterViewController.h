//
//  ParameterViewController.h
//  Youtube
//
//  Created by boris charpentier on 09/05/11.
//  Copyright 2011 bcharp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParameterViewController : UIViewController <UITextFieldDelegate>{
	IBOutlet UITextField *textField;
}
-(IBAction)done;
@end
