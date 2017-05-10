//
//  Todo.h
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/8/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property(strong, nonatomic)NSString *title;
@property(strong, nonatomic)NSString *content;
@property(strong, nonatomic)NSString *key;
@property(strong, nonatomic)NSNumber *completed;

@end
