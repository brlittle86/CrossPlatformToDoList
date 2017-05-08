//
//  ViewController.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/8/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController ()

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
    
}

//Only here for testing purposes
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    
    NSLog(@"%@", segue.destinationViewController);
}

//Determine if user is logged in or not | Prompt login if not
- (void)checkUserStatus{
    
    if (![[FIRAuth auth] currentUser]) {
        
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
        
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
    
}

//Establishes connection with remote database for current user
- (void)setupFirebase{
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
    
}

//sets up a listener for when data in the database is updated
- (void)startMonitoringTodoUpdates{
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue
                                                                       withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                                                           
                                                                           NSMutableArray *allTodos = [[NSMutableArray alloc] init];
                                                                           
                                                                           for (FIRDataSnapshot *child in snapshot.children) {
                                                                               
                                                                               NSDictionary *todoData = child.value;
                                                                               NSString *todoTitle = todoData[@"title"];
                                                                               NSString *todoContent = todoData[@"content"];
                                                                               
                                                                               //for lab, append new 'Todo' to allTodos array
                                                                               NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
                                                                               
                                                                           }
                                                                           
                                                                       }];
    
}

- (IBAction)addTodoItemButtonPressed:(id)sender {
}

- (IBAction)logoutButtonPressed:(id)sender {
    
    NSError *logoutError;
    [[FIRAuth auth] signOut:&logoutError];
    
    [self checkUserStatus];
    
}

@end
