//
//  Todo.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/8/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "Todo.h"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content andKey:(NSString *)key{
    self = [super init];
    
    if (self) {
        _title = title;
        _content = content;
        _key = key;
        _completed = @0;
    }
    
    return self;
}

@end
