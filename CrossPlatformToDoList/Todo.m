//
//  Todo.m
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/8/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "Todo.h"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    self.title = title;
    self.content = content;
    
    return self;
}

@end
