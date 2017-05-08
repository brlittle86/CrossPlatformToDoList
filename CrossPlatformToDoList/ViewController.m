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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *allTodos;

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;
@property (weak, nonatomic) IBOutlet UIView *addTodoContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addTodoTop;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
                                                                           
                                                                           self.allTodos = [[NSMutableArray alloc] init];
                                                                           
                                                                           for (FIRDataSnapshot *child in snapshot.children) {
                                                                               
                                                                               NSDictionary *todoData = child.value;
                                                                               NSString *todoTitle = todoData[@"title"];
                                                                               NSString *todoContent = todoData[@"content"];
                                                                               
                                                                               //for lab, append new 'Todo' to allTodos array
                                                                               NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
                                                                               [self.allTodos addObject:child];
                                                                               
                                                                           }
                                                                           
                                                                           for (FIRDataSnapshot *child in self.allTodos) {
                                                                               
                                                                           }
                                                                           
                                                                       }];
    
}

- (IBAction)addTodoItemButtonPressed:(id)sender {
    
    double defaultTop = (-150);
    double openTop = 0;
    
    if (self.addTodoContainer.hidden == YES) {
        [self.addTodoContainer setHidden:NO];
        self.addTodoTop.constant = openTop;
    } else {
        [self.addTodoContainer setHidden:YES];
        self.addTodoTop.constant = defaultTop;
    }
    
}

- (IBAction)logoutButtonPressed:(id)sender {
    
    NSError *logoutError;
    [[FIRAuth auth] signOut:&logoutError];
    
    [self checkUserStatus];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    FIRDataSnapshot *child = [self.allTodos objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", child[@"title"]];
    
    return cell;
}

@end
