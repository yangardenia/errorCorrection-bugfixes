//
//  AddEventsController.m
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "AddEventsController.h"
#import "EventsTool.h"
#import "AppDelegate.h"
#import "CoreDataManager.h"
#import "EventStoreManager.h"

@interface AddEventsController ()
{
    UIScrollView *bgView;
}

@end

@implementation AddEventsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc {
    self.tabBarController.selectedIndex = 1;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -40, 320, self.view.height + 80)];
    bgView.contentSize = CGSizeMake(self.view.width, self.view.height * 2);
    bgView.delegate = self;
    bgView.scrollEnabled = YES;
    bgView.showsVerticalScrollIndicator = NO;
    bgView.decelerationRate = UIScrollViewDecelerationRateFast;
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    UIControl *control = [[UIControl alloc] initWithFrame:bgView.frame];
//    control.backgroundColor = [UIColor redColor];
//    [control addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:control];
    
    UIButton *leftB = [UIButton buttonWithType:UIButtonTypeCustom];
    leftB = [UIButton buttonWithType:UIButtonTypeCustom];
    leftB.frame = CGRectMake(260, 2, 50, 44);
    [leftB setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftB setTitle:@"保存" forState:UIControlStateNormal];
    [leftB addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftB];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10,50, 320, 20)];
    title.text = @"标题";
    [title setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:title];
    
    self.textTitle = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, 300, 30)];
    self.textTitle.backgroundColor = [UIColor whiteColor];
    self.textTitle.text = self.eventObj.name;
    [bgView addSubview:self.textTitle];
    
    UILabel *level = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 320, 20)];
    level.text = @"等级";
    [level setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:level];
    
    self.textLevel = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, 300, 30)];
    self.textLevel.backgroundColor = [UIColor whiteColor];
    self.textLevel.text = self.eventObj.level;
    [bgView addSubview:self.textLevel];
    
    UILabel *descript = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 320, 20)];
    descript.text = @"描述";
    [descript setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:descript];
    
    self.textDescript = [[UITextView alloc]initWithFrame:CGRectMake(10,220, 300, self.view.frame.size.height)];
    self.textDescript.delegate = self;
    self.textDescript.backgroundColor = [UIColor whiteColor];
    self.textDescript.text = self.eventObj.descrip;
    self.textDescript.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:self.textDescript];
    [self.view addSubview:bgView];
}

-(void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAction{
    if (self.eventObj) {//修改事件
        self.eventObj.name = self.textTitle.text;
        self.eventObj.descrip = self.textDescript.text;
        self.eventObj.level = self.textLevel.text;
        self.eventObj.time = [NSDate dateWithTimeIntervalSinceNow:0];
        self.eventObj.status = @"1";
        [[EventStoreManager sharedManager] insertNewEventTool:self.eventObj];
    }else {//添加事件
        EventsTool *event = [[EventsTool alloc]init];
        event.name = self.textTitle.text;
        event.descrip = self.textDescript.text;
        event.level = self.textLevel.text;
        event.time = [NSDate dateWithTimeIntervalSinceNow:0];
        event.status = @"1";
        [[EventStoreManager sharedManager] insertNewEventTool:event];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    bgView.frame = CGRectMake(0, -90, 320, self.view.height + 80);
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    bgView.frame = CGRectMake(0, -40, 320, self.view.height + 80);
    [self.textDescript resignFirstResponder];
    [self.textLevel resignFirstResponder];
    [self.textTitle resignFirstResponder];
}

@end
