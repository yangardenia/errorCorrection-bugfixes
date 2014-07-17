//
//  CoreDataManager.h
//  EventManager
//
//  Created by jianzhongliu on 4/2/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"

@interface CoreDataManager : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)initWithUID:(NSString *) uid;
- (NSArray *)fetchEventList;
- (void)switchDataWithUID:(NSString *) uid;
- (Events *)findMessageWithId:(NSString *) Id;
- (BOOL)isEventExistsWithEventId:(NSString *)EventId;
- (NSArray *)fetchHistoryEventList;
- (void)deleteEventById:(NSString *)Id;
- (void)updateEvent:(EventsTool *)event;
- (void)insertNewEventTool:(EventsTool *) event;
@end
