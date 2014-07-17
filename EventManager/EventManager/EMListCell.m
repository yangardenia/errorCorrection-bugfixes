//
//  EMTableViewCell.m
//  EventManager
//
//  Created by yons on 13-10-3.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "EMListCell.h"
#import "EventsTool.h"

@implementation EMListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 300, 20)];
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = [UIColor redColor];
        title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:title];

        level = [[UILabel alloc] initWithFrame:CGRectMake(10, 23, 100, 20)];
        level.textAlignment = NSTextAlignmentLeft;
        level.textColor = [UIColor lightGrayColor];
        level.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:level];

        status = [[UILabel alloc] initWithFrame:CGRectMake(70, 23, 100, 20)];
        status.textAlignment = NSTextAlignmentLeft;
        status.textColor = [UIColor lightGrayColor];
        status.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:status];

        time = [[UILabel alloc] initWithFrame:CGRectMake(150, 23, 160, 20)];
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = [UIColor lightGrayColor];
        time.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:time];

        descript = [[UILabel alloc] initWithFrame:CGRectMake(10, 43, 300, 27)];
        descript.textAlignment = NSTextAlignmentLeft;
        descript.textColor = [UIColor lightGrayColor];
        descript.numberOfLines = 0;
        descript.lineBreakMode = NSLineBreakByWordWrapping;
        descript.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:descript];

        // Initialization code
    }
    return self;
}

-(void)valueOfTableCell:(id)object withIndex:(NSIndexPath *)indexPath{
    if([object isKindOfClass:[EventsTool class]]){
        EventsTool *events = (EventsTool *)object;
        title.text = [NSString stringWithFormat:@"标题_%d:%@", [indexPath row] +1, events.name];
        level.text = [NSString stringWithFormat:@"优先级:%@", events.level];
        status.text  = [NSString stringWithFormat:@"状态:%@", events.status];
        NSDateFormatter *dateFormatrer = [[NSDateFormatter alloc] init];
        dateFormatrer.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateFormatrer.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        
        NSString *tempStr = [dateFormatrer stringFromDate:events.time];
        
        time.text = [NSString stringWithFormat:@"时间:%@", tempStr];
        descript.text = [NSString stringWithFormat:@"描述:%@", events.descrip];
    }else{
        return;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
