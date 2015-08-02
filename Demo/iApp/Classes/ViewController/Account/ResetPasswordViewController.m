//
//  ResetPasswordViewController.m
//  iApp
//
//  Created by icoco7 on 12/12/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Utils roundRectView:self.continueButton];
    
    self.title = AppLocalizedString(@"Reset Password");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)onSubmit:(id)sender;
{
    [self.emailField resignFirstResponder];
    NSString* email =  self.emailField.text;
    if ([Lang isEmptyString:email]) {
        return;
    }
    
    //@step
    OCAccountService* serivce = [OCAccountService forgotten:email];
    [serivce execute:^(id response) {
        NSDictionary* dict = (NSDictionary*)response;
        NSString* status = [dict stringValueForPath:@"status"];
        BOOL success = [@"success" isEqualToString:status];
        if ( success)
        {
            NSString* message = [response valueForKey:@"data"];
            [CDialogViewManager showMessageView: @"" message:message delayAutoHide:-1];
            [self.navigationController popViewControllerAnimated:true];
        }else
        {
            NSString* message = [response valueForKey:@"data"];
            
            [CDialogViewManager showMessageView: @"" message:message delayAutoHide:-1];
            
            //[Resource showRestResponseErrorMessage:response];
        }

        
    } failure:^(NSError *error) {
        
        [CDialogViewManager showMessageView: [Lang trimString:[error localizedDescription]] message:nil delayAutoHide: 3];
        
    }];
 }
@end
