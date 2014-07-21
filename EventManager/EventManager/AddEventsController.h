//
//  AddEventsController.h
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsTool.h"

@interface AddEventsController : UIViewController <UITextViewDelegate, UIScrollViewDelegate>
{


}
@property (nonatomic,strong) UITextField *textTitle;
@property (nonatomic,strong) UITextField *textLevel;
@property (nonatomic,strong) UITextView *textDescript;
@property (nonatomic, strong) EventsTool *eventObj;
@end
