//
//  AppDelegate.h
//  EventManager
//
//  Created by yons on 13-10-1.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EventsTool.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
+(id)G;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSArray *)dataFetchRequest;
- (void)insertCoreData:(EventsTool *)events;
@end
