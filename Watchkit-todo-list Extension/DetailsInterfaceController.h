//
//  DetailsInterfaceController.h
//  CrossPlatformToDoList
//
//  Created by Brandon Little on 5/9/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "Todo.h"

@interface DetailsInterfaceController : WKInterfaceController

@property (strong, nonatomic) Todo *currentTodo;

@end
