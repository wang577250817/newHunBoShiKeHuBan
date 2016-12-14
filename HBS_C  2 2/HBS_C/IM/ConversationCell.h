//
//  ConversationCell.h
//  HuangXinDemo
//
//  Created by wangzuowen on 16/7/19.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMListModel.h"

@interface ConversationCell : UITableViewCell

@property (nonatomic, retain) EMConversation *conversation;
@property (nonatomic, strong)IMListModel *model;

@end
