//
//  TVDetailViewController.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/9/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "TVDetailViewController.h"

@interface TVDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleLabel setText:self.currentTodo.title];
    [self.contentLabel setText:self.currentTodo.content];
}

@end
