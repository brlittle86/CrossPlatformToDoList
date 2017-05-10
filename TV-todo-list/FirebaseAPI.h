//
//  FirebaseAPI.h
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/10/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

typedef void(^AllTodosCompletion)(NSArray<Todo *> *allTodos);

@interface FirebaseAPI : NSObject

+(void)fetchAllTodos:(AllTodosCompletion)completion;

@end
