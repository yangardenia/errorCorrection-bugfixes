//
//  LoginViewController.m
//  EventManager
//
//  Created by jianzhongliu on 4/17/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    UITextField *text;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

    text = [[UITextField alloc] initWithFrame:CGRectMake(85, 150, 150, 30)];
    text.keyboardType = UIKeyboardTypePhonePad;
    text.placeholder = @"输入密码";
    [text becomeFirstResponder];
    text.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:text];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(10, 200, 300, 30);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor greenColor]];
    [login addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:login];
    // Do any additional setup after loading the view.
}

- (void)click {
    if ([text.text isEqual:@"7673"]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不对" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
}

@end
