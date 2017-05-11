//
//  TVHomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/9/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TVDetailViewController.h"
#import "TVEmailViewController.h"
#import "FirebaseAPI.h"

#import "Todo.h"

@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;
@property (strong, nonatomic) NSString *userEmail;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self checkForUserEmail];
    
    [FirebaseAPI fetchAllTodos:^(NSArray<Todo *> *allTodos) {
        NSLog(@"%@", allTodos);
        
        self.allTodos = allTodos;
        [self.tableView reloadData];
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForUserEmail{
    if (!self.userEmail) {
        TVEmailViewController *emailView = [self.storyboard instantiateViewControllerWithIdentifier:@"TVEmailViewController"];
        [self presentViewController:emailView animated:YES completion:nil];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allTodos.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TVDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"TVDetailViewController"];
    detailView.currentTodo = self.allTodos[indexPath.row];
    
    [self presentViewController:detailView animated:YES completion:nil];
}

@end
