//
//  Events.m
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "Events.h"


@implementation Events

@dynamic descrip;
@dynamic ident;
@dynamic level;
@dynamic name;
@dynamic parentId;
@dynamic status;
@dynamic time;

- (void)assignPropertiesFromMappedObject:(EventsTool *)event {
    self.descrip = event.descrip;
    self.level = event.level;
#warning 为什么不加上ident，
    self.name = event.name;
    self.parentId = event.parentId;
    self.status = event.status;
    self.time = event.time;
}

- (EventsTool *)convertToMappedEventsTool {
    EventsTool *eventTool = [[EventsTool alloc] init];
    eventTool.descrip = self.descrip;
    eventTool.ident = self.ident;
    eventTool.level = self.level;
    eventTool.name = self.name;
    eventTool.parentId = self.parentId;
    eventTool.status = self.status;
    eventTool.time = self.time;
    return eventTool;
}
- (void)awakeFromInsert
{
    CFUUIDRef uuidObj = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidObj);
    NSString *uuidString = [NSString stringWithString:(NSString*)CFBridgingRelease(strRef)];
    self.ident = uuidString;
    self.descrip = @"--";
    self.level = @"1";
    self.name = @" ";
    self.parentId = [NSNumber numberWithInt:222];
    self.status = @"1";
    self.time = [NSDate date];
    CFRelease(uuidObj);
}
@end
