//
//  CoreDataManager.m
//  EventManager
//
//  Created by jianzhongliu on 4/2/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import "CoreDataManager.h"
#import "Events.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager ()
{

}


@end

@implementation CoreDataManager
- (instancetype)initWithUID:(NSString *) uid {
    if (self = [super init]) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Event" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        [self switchDataWithUID:uid];
    }
    return self;
}

- (void)switchDataWithUID:(NSString *) uid {
    if (self.managedObjectContext) {
        [self.managedObjectContext save:NULL];
    }
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sqlitePath = [library stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", uid]];
    NSLog(@"%@",sqlitePath);
    NSDictionary * opt = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    __autoreleasing NSError *error = nil;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if ([self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:opt error:&error]) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
}

- (void)dealloc {
    [self.managedObjectContext save:nil];
}

- (NSArray *)fetchEventList{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"status = 1"];
    fetchRequest.fetchLimit = 100;
    __autoreleasing NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *eventToolArray = [NSMutableArray array];
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Events *event = (Events *)obj;
        EventsTool *eventsTool = [event convertToMappedEventsTool];
        [eventToolArray addObject:eventsTool];
    }];
    NSArray *sortedArray = [NSArray array];
    
//按照等级排序
  sortedArray = [eventToolArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
      
      EventsTool *event1 = obj1;
      EventsTool *event2 = obj2;
      if ([event1.level isEqualToString:event2.level]) {
          NSComparisonResult result = [event1.time compare:event2.time];
          return result == NSOrderedAscending;
      }
      NSComparisonResult result = [event1.level compare:event2.level];
        return result == NSOrderedDescending;//升序
    }];
    
    return sortedArray;
}

- (NSArray *)fetchHistoryEventList{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"status = 0"];
    fetchRequest.fetchLimit = 100;
    __autoreleasing NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *eventToolArray = [NSMutableArray array];
    [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Events *event = (Events *)obj;
        EventsTool *eventsTool = [event convertToMappedEventsTool];
        
        [eventToolArray addObject:eventsTool];
    }];
    //按照时间排序
    NSArray *sortedArray = [NSArray array];
    sortedArray = [eventToolArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        EventsTool *event1 = obj1;
        EventsTool *event2 = obj2;
        NSComparisonResult result = [event1.time compare:event2.time];
        return result == NSOrderedAscending;
    }];
    
    return sortedArray;
}

- (void)deleteEventById:(NSString *)Id
{
    Events *event = [self findMessageWithId:Id];
    [self.managedObjectContext deleteObject:event];
//    [self.managedObjectContext save:NULL];
}

- (Events *)findMessageWithId:(NSString *) Id
{
    if (Id == nil) {
        return nil;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"ident = %@", Id];
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    if ([result count] > 0) {
        return [result firstObject];
    } else {
        return nil;
    }
}

- (BOOL)isEventExistsWithEventId:(NSString *)EventId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"ident = %@", EventId];
    __autoreleasing NSError *error;
    NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    if (count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateEvent:(EventsTool *)event
{
    Events *eventToUpdate = [self findMessageWithId:event.ident];
    if (eventToUpdate == nil) {
        eventToUpdate = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
    }
//    event.isPendingForAdd = NO;
    [eventToUpdate assignPropertiesFromMappedObject:event];
    [self save];
}

- (void)insertNewEventTool:(EventsTool *) event {
    Events *messageToInsert = [self findMessageWithId:event.ident];
    if (!messageToInsert) {
        messageToInsert = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:self.managedObjectContext];
//        [self save];
    }
    [messageToInsert assignPropertiesFromMappedObject:event];
    [self save];
}

- (void)save {
    __autoreleasing NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"coredata ERROR%@", error.userInfo);
    }
}

@end
