//
//  Events.h
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EventsTool.h"

@interface Events : NSManagedObject

@property (nonatomic, strong) NSString * descrip;
@property (nonatomic, strong) NSString * ident;
@property (nonatomic, strong) NSString * level;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * parentId;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSDate * time;
- (void)assignPropertiesFromMappedObject:(EventsTool *)event;
- (EventsTool *)convertToMappedEventsTool;

@end
