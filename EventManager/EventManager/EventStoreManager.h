//
//  EventStoreManager.h
//  EventManager
//
//  Created by jianzhongliu on 4/3/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventsTool.h"
#import "CoreDataManager.h"

@interface EventStoreManager : NSObject

+ (instancetype)sharedManager;

- (void)insertNewEventTool:(EventsTool *) event;
- (NSArray *)fetchEventList;
- (NSArray *)fetchHistoryEventList;
- (void)updateEventsOfDelete:(EventsTool *)event;
@end
