//
//  LoginViewController.m
//  EventManager
//
//  Created by jianzhongliu on 4/17/14.
//  Copyright (c) 2014 yons. All rights reserved.
//

#import "LoginViewController.h"

NSString *const xiaoxia = @"yangardenia";

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordInput;

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

    self.passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(85, 150, 150, 30)];
    self.passwordInput.keyboardType = UIKeyboardTypeDefault;
    self.passwordInput.delegate = self;
    self.passwordInput.placeholder = @"输入密码";
    [self.passwordInput becomeFirstResponder];
    self.passwordInput.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.passwordInput];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(10, 200, 300, 30);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor greenColor]];
    [login addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:login];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)click {
    if ([self.passwordInput.text isEqual:xiaoxia]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不对" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    if ([toBeString isEqualToString:xiaoxia]) {
        [self click];
    }
}

@end
