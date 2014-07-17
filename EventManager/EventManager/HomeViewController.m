//
//  HomeViewController.m
//  MyTestTabBar
//
//  Created by ios on 13-2-20.
//  Copyright (c) 2013年 liujianzhong. All rights reserved.
//

#import "HomeViewController.h"
#import "EMListCell.h"
#import "AddEventsController.h"
#import "AppDelegate.h"
#import "EventStoreManager.h"
#import "AddEventsController.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"列表";
        dataSource = [[NSMutableArray alloc] initWithCapacity:16];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBar.frame = CGRectMake(0, 0, 40, 20);
    [rightBar setTitle:@"添加" forState:UIControlStateNormal];
    [rightBar setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBar addTarget:self  action:@selector(addEvents) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItems = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    [self.navigationItem setRightBarButtonItem:buttonItems];
//    self.navigationItem.rightBarButtonItem = leftBar;
    
    myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    myTableView.height = self.view.height - 66;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
    
    LoginViewController *controller = [[LoginViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [dataSource removeAllObjects];
    [dataSource addObjectsFromArray:[[EventStoreManager sharedManager] fetchEventList]];
    [myTableView reloadData];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddEventsController *controller = [[AddEventsController alloc] init];
    controller.eventObj = [dataSource objectAtIndex:indexPath.row];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellIdent = @"EMListCell";
    EMListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if(cell == nil) {
        cell = [[EMListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    [cell valueOfTableCell:[dataSource objectAtIndex:indexPath.row] withIndex:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addEvents{
    AddEventsController *controller = [[AddEventsController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
//    [self presentViewController:controller animated:YES completion:^{
    
//    }];
}
@end
