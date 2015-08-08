//
//  ViewController.h
//  TextFieldHomework
//
//  Created by kateryna.zaikina on 02.08.15.
//  Copyright (c) 2015 kateryna.zaikina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *backgroundImageViews;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsForm;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelsToPrint;

- (IBAction)actionTextChange:(UITextField *)sender;

@end

