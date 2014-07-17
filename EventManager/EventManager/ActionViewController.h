//
//  ActionViewController.h
//  MyTestTabBar
//
//  Created by ios on 13-2-20.
//  Copyright (c) 2013年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"

@interface ActionViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *myArray;
@end
