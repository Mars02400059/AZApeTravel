//
//  AZBaseAmountTextFField.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/4.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseAmountTextFField.h"

@implementation AZBaseAmountTextFField

- (BOOL)textField:(AZBaseAmountTextFField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}



@end
