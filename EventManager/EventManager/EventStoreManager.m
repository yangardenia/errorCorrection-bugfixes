//
//  EventStoreManager.m
//  EventManager
//
//  Created by jianzhongliu on 4/3/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import "EventStoreManager.h"

@interface EventStoreManager ()

@property (nonatomic, strong) CoreDataManager *dataManager;

@end


@implementation EventStoreManager

+ (instancetype)sharedManager {
    static EventStoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EventStoreManager alloc] init];
    });
    return manager;
}

- (CoreDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[CoreDataManager alloc] initWithUID:@"Events"];
    }
    return _dataManager;
}

- (void)insertNewEventTool:(EventsTool *) event {
    if ([self.dataManager isEventExistsWithEventId:event.ident]) {
        [self.dataManager updateEvent:event];
    }else {
        [self.dataManager insertNewEventTool:event];
    }
}

- (NSArray *)fetchEventList {
    return [self.dataManager fetchEventList];
}
- (NSArray *)fetchHistoryEventList {
    return [self.dataManager fetchHistoryEventList];
}
- (void)updateEventsOfDelete:(EventsTool *)event {
    event.status = @"0";
    [self.dataManager updateEvent:event];
}
@end
