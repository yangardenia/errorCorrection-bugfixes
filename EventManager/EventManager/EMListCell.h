//
//  EMTableViewCell.h
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMListCell : UITableViewCell
{
    UILabel *title;
    UILabel *time;
    UILabel *descript;
    UILabel *level;
    UILabel *status;
    UILabel *index;
}

-(void)valueOfTableCell:(id)object withIndex:(NSIndexPath *)indexPath;

@end
