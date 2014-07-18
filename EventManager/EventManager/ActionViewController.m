//
//  ActionViewController.m
//  MyTestTabBar
//
//  Created by ios on 13-2-20.
//  Copyright (c) 2013年 liujianzhong. All rights reserved.
//

#import "ActionViewController.h"
#import "EMListCell.h"
#import "EventStoreManager.h"

@interface ActionViewController ()

@end

@implementation ActionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"操作";
        self.myArray = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor blueColor]];
    
    self.myTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.myTable.height = self.view.height - 66;
    self.myTable.dataSource = self;
    self.myTable.delegate = self;
    [self.view addSubview:self.myTable];
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    [self.myArray removeAllObjects];
    [self.myArray addObjectsFromArray:[[EventStoreManager sharedManager] fetchEventList]];
    [self.myTable reloadData];

}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[EventStoreManager sharedManager] updateEventsOfDelete:[self.myArray objectAtIndex:indexPath.row]];
    [self reloadData];
//    AddEventsController *controller = [[AddEventsController alloc] init];
//    controller.eventObj = [dataSource objectAtIndex:indexPath.row];
//    [controller setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.myArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"EMListCell";
    EMListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if(cell == nil) {
        cell = [[EMListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    [cell valueOfTableCell:[self.myArray objectAtIndex:indexPath.row] withIndex:indexPath];
    return cell;
}

@end
