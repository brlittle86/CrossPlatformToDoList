//
//  LoginViewController.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/8/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "LoginViewController.h"

@import FirebaseAuth;

@interface LoginViewController ()

//Properties for the text fields
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//Handles what happens when pressing the login button
- (IBAction)loginButtonPressed:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text
                           password:self.passwordTextField.text
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
                             if (error) {
                                 NSLog(@"Error Signing In: %@", error.localizedDescription);
                             }
                             
                             if (user) {
                                 NSLog(@"Logged In User: %@", user);
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }
                             
    }];
    
}

//Handles what happens when pressing the sign up button
- (IBAction)signupButtonPressed:(id)sender {
    
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text
                               password:self.passwordTextField.text
                             completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                                 
                                 if (error) {
                                     NSLog(@"Error Signing Up New User: %@", error.localizedDescription);
                                 }
                                 
                                 if (user) {
                                     NSLog(@"Successfully Signed Up User: %@", user);
                                 }
                                 
    }];
    
}

@end
