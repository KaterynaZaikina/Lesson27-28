//
//  ViewController.m
//  TextFieldHomework
//
//  Created by kateryna.zaikina on 02.08.15.
//  Copyright (c) 2015 kateryna.zaikina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    for (UITextField *field in self.textFieldsForm) {
        field.delegate = self;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - My methods

- (BOOL) checkEmail: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableCharacterSet *validationSet = [NSMutableCharacterSet letterCharacterSet];
    [validationSet formUnionWithCharacterSet:[NSMutableCharacterSet decimalDigitCharacterSet]];
    [validationSet addCharactersInString:@"@."];
    [validationSet invert];
    
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSRange newRange = [textField.text rangeOfString:@"@"];
    
    if (newRange.location != NSNotFound && [string isEqualToString:@"@"]) {
        return NO;
        }
    
    if ([components count] > 1) {
        return NO;
    }
    
    UILabel *label = [self.labelsToPrint objectAtIndex:5];
    label.text = textField.text = newString;

    return YES;
}

- (BOOL) checkAge: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components =[string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([newString integerValue]>120) {
        
        return NO;
    }
    
    UILabel *label = [self.labelsToPrint objectAtIndex:4];
    label.text = textField.text = newString;
    return YES;

}

- (BOOL) checkPhoneNumber:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components =[string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
       return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 2;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        
      return NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    
    // +XX (XXX) XXX-XXXX
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString *area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@)", area];
        
        [resultString insertString:area atIndex:0];
        
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryRange = NSMakeRange(0, countryCodeLength);
        
        NSString *country = [newString substringWithRange:countryRange];
        
        country = [NSString stringWithFormat:@"+%@ ", country];
        
        [resultString insertString:country atIndex:0];
        
    }
    
    UILabel *label = [self.labelsToPrint objectAtIndex:5];
    label.text = textField.text = resultString;
    
    return NO;

}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    switch (textField.tag) {
        case 4:
            
            [self checkAge:textField shouldChangeCharactersInRange:range replacementString:string];

            break;
            
            case 5:
            
            [self checkPhoneNumber:textField shouldChangeCharactersInRange:range replacementString:string];
            
            break;
            
            case 6:
            
            [self checkEmail:textField shouldChangeCharactersInRange:range replacementString:string];
            
            break;
            
        default: return YES;
            break;
        
        }
    
    return NO;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    for (UILabel *label in self.labelsToPrint) {
        
                if (label.tag == textField.tag) {
        
                label.text = @"";
        
                }
            }

    
    return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag < [self.textFieldsForm count]-1) {
        
        [[self.textFieldsForm objectAtIndex:textField.tag+1] becomeFirstResponder];
        
    } else {
    
        [textField resignFirstResponder];
    }
    
  return YES;

}

#pragma mark - Actions

- (IBAction)actionTextChange:(UITextField *)sender {
    
    for (UILabel *label in self.labelsToPrint) {
        if (label.tag == sender.tag && label.tag != 3) {
        
        label.text = sender.text;
        
        }
    }
}
@end
