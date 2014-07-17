//
//  HomeViewController.h
//  MyTestTabBar
//
//  Created by ios on 13-2-20.
//  Copyright (c) 2013年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
}
@end
