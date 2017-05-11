//
//  FirebaseAPI.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/10/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Header.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion{
    
    NSString *urlString = [NSString stringWithFormat:@"https://crossplatform-todo-list.firebaseio.com/users.json?auth=%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
                NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
//                NSLog(@"ROOT OBJECT:%@", rootObject);
                
                NSMutableArray *allTodos = [[NSMutableArray alloc]init];
                
                for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
                    NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];
                    
                    for (NSDictionary *todoDictionary in userTodos) {
                        Todo *newTodo = [[Todo alloc]init];
                        newTodo.title = todoDictionary[@"title"];
                        newTodo.content = todoDictionary[@"content"];
                        newTodo.key = todoDictionary[@"key"];
                        newTodo.completed = todoDictionary[@"completed"];
                        
                        //insert if statement here, to only add todo with user's email
                        [allTodos addObject:newTodo];
                        
                    }
                    
                }
                
                if (completion) {
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        completion(allTodos);
                    }];
                    
                }
        
    }] resume]; //data task cannot execute without the resume
    
}

@end
