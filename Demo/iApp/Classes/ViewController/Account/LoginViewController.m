//
//  LoginViewController.m
//  iCart
//
//  Created by icoco7 on 5/21/14.
//  Copyright (c) 2014 i2Cart.com. All rights reserved.
//

#import "LoginViewController.h"
#import "AppManager.h"
#import "DataModel.h"
#import "CUIEnginer.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.navigationController) {
        self.title = AppLocalizedString(@"Login");
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:) ];
    }
    //@step
    [Utils roundRectView:self.loginButton];
    [Utils roundRectView:self.forgotPasswordButton];
    [Utils roundRectView:self.registerButton];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeView:(id)sender
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}


- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
    //@step
    OCCustomer* user =[[DataModel sharedInstance]getActiveUser];
    if (nil == user || ![user isValidateUser]) {
        [[AppManager sharedInstance] showHomeViewInKeyWindow:0];
    }

}

- (IBAction)onLogin:(id)sender{
    
    NSString* email = self.emailTextField.text;
    NSString* password = self.passwordTextField.text;
    
    OCAccountService* serivce = [OCAccountService login: email password:password];
    [serivce execute:^(id response) {
        BOOL success =[[DataModel sharedInstance]onLoginDone:response];
        if (success) {
            [[DataModel sharedInstance ]storeUserAccountInfo:email password:password];
            //@step login succcess
            [self closeView:nil];
            return ;

        }
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)onTouchScreen:(id)sender
{
    if (self.emailTextField.editing) {
        [self.emailTextField resignFirstResponder];
        
    }
    if (self.passwordTextField.editing) {
        [self.passwordTextField resignFirstResponder];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self performSelector:@selector(onLogin:) withObject:nil afterDelay:8];
    return true;
}

- (IBAction)newCustomer:(id)sender{
    
    NSString* class = @"RegisterViewController";

    UIViewController* viewController = [CUIEnginer createViewController:class inNavigationController:false];
    [self.navigationController pushViewController:viewController animated:true];

}

- (IBAction)resetPassword:(id)sender
{
    
    NSString* class = @"ResetPasswordViewController";
    
    UIViewController* viewController = [CUIEnginer createViewController:class inNavigationController:false];
    [self.navigationController pushViewController:viewController animated:true];
}
@end
