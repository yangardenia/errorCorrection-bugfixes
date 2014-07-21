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

#pragma mark - lifeCycleMethods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - getter & setter Methods
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 300, 20)];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor redColor];
        _title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_title];
    }
    return _title;
}

- (UILabel *)level {
    if (_level == nil) {
        _level = [[UILabel alloc] initWithFrame:CGRectMake(10, 23, 100, 20)];
        _level.textAlignment = NSTextAlignmentLeft;
        _level.textColor = [UIColor lightGrayColor];
        _level.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_level];
    }
    return _level;
}

- (UILabel *)status {
    if (_status == nil) {
        _status = [[UILabel alloc] initWithFrame:CGRectMake(70, 23, 100, 20)];
        _status.textAlignment = NSTextAlignmentLeft;
        _status.textColor = [UIColor lightGrayColor];
        _status.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_status];
    }
    return _status;
}

- (UILabel *)time {
    if (_time == nil) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(150, 23, 160, 20)];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.textColor = [UIColor lightGrayColor];
        _time.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_time];
    }
    return _time;
}

- (UILabel *)descript {
    if (_descript == nil) {
        _descript = [[UILabel alloc] initWithFrame:CGRectMake(10, 43, 300, 27)];
        _descript.textAlignment = NSTextAlignmentLeft;
        _descript.textColor = [UIColor lightGrayColor];
        _descript.numberOfLines = 0;
        _descript.lineBreakMode = NSLineBreakByWordWrapping;
        _descript.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_descript];
    }
    return _descript;
}

#pragma mark - ResetValuesMethods
-(void)valueOfTableCell:(id)object withIndex:(NSIndexPath *)indexPath{
    if([object isKindOfClass:[EventsTool class]]){
        EventsTool *events = (EventsTool *)object;
        self.title.text = [NSString stringWithFormat:@"标题_%d:%@", [indexPath row] +1, events.name];
        self.level.text = [NSString stringWithFormat:@"优先级:%@", events.level];
        self.status.text  = [NSString stringWithFormat:@"状态:%@", events.status];
        NSDateFormatter *dateFormatrer = [[NSDateFormatter alloc] init];
        dateFormatrer.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateFormatrer.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        
        NSString *tempStr = [dateFormatrer stringFromDate:events.time];
        
        self.time.text = [NSString stringWithFormat:@"时间:%@", tempStr];
        self.descript.text = [NSString stringWithFormat:@"描述:%@", events.descrip];
    }else{
        return;
    }
}

@end
