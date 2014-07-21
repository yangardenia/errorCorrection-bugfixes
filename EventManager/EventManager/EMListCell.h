//
//  EMTableViewCell.h
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMListCell : UITableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *descript;
@property (nonatomic, strong) UILabel *level;
@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UILabel *index;

-(void)valueOfTableCell:(id)object withIndex:(NSIndexPath *)indexPath;

@end
