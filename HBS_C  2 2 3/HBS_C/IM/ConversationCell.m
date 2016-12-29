 //
//  ConversationCell.m
//  HuangXinDemo
//
//  Created by wangzuowen on 16/7/19.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "ConversationCell.h"

@interface ConversationCell()

@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *meowID;
@property (nonatomic, retain) UILabel *message;
@property (nonatomic, retain) UILabel *time;
@property (nonatomic, retain) UIImageView *circle;
@property (nonatomic, retain) UILabel *unReadNum;


@end
@implementation ConversationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super  initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubviews];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.image setFrame:CGRectMake(10, 10, 50*WSHIPEI, 50*WSHIPEI)];
    
    self.image.layer.cornerRadius = 25 * WSHIPEI;
//    self.image.backgroundColor = HONGSE;
    self.image.layer.masksToBounds = YES;
    
    
    [self.meowID setFrame:CGRectMake(CGRectGetMaxX(self.image.frame) + 10, 10, WIDTH - (150 + 50 * WSHIPEI), 25)];
    
    [self.message setFrame:CGRectMake(self.meowID.frame.origin.x, CGRectGetMaxY(self.meowID.frame), WIDTH - CGRectGetMaxX(self.image.frame) - 80, 25)];
    
    self.time.frame = CGRectMake(WIDTH - 120, 15, 110, 20);
    [self.circle setFrame:CGRectMake(WIDTH - 36, 40, 20, 20)];
    
    [self.unReadNum setFrame:self.circle.bounds];
    
}

- (void)createSubviews {
    
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    
    self.meowID = [[UILabel alloc] init];
    [self.meowID setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:self.meowID];
    
    self.message = [[UILabel alloc] init];
    [self.message setFont:[UIFont systemFontOfSize:14.0f]];
    [self.message setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:self.message];
    
    self.time = [[UILabel alloc] init];
    [self.time setTextColor:[UIColor grayColor]];
    [self.time setTextAlignment:NSTextAlignmentRight];
    [self.time setFont:[UIFont systemFontOfSize:12.0f]];
    [self.contentView addSubview:self.time];
    
    self.circle = [[UIImageView alloc] init];
    self.circle.layer.cornerRadius = 10;
    self.circle.layer.masksToBounds = YES;
    self.circle.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.circle];
    
    self.unReadNum = [[UILabel alloc] init];
    [self.unReadNum setTextColor:[UIColor whiteColor]];
    [self.unReadNum setFont:[UIFont systemFontOfSize:12.0f]];
    [self.unReadNum setTextAlignment:NSTextAlignmentCenter];
    [self.circle addSubview:self.unReadNum];
}

#pragma mark - 模型赋值
- (void)setConversation:(EMConversation *)conversation {
    
    if (_conversation != conversation) {
        
        _conversation = conversation;
    }
    
    if (![_conversation.conversationId isEqualToString:[[EMClient sharedClient] currentUsername]] || ![_conversation.conversationId isEqualToString:@""]) {
        
        //会话标识符
//        self.meowID.text = self.model.reakl_name;
        //头像  未知
//        [self.image setImageWithURL:[NSURL URLWithString:self.model.head_pic] refreshCache:YES placeholderImage:ZHANWEI];
        
        //未读消息数
        if (_conversation.unreadMessagesCount == 0) {
            self.circle.hidden = YES;
        } else {
            self.circle.hidden = NO;
            self.unReadNum.text = [NSString stringWithFormat:@"%d", self.conversation.unreadMessagesCount];
        }
        //最后一次会话时间
        NSString *str = [NSDate formattedTimeFromTimeInterval:self.conversation.latestMessage.timestamp];
        self.time.text = str;
        //最新的一条消息
        EMMessageBody *messageBody = _conversation.latestMessage.body;
        if (messageBody.type == EMMessageBodyTypeText) {
            EMTextMessageBody *textBody = (EMTextMessageBody *)messageBody;
            if (!textBody) {
                self.message.text = @"";
            } else {
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                self.message.text = didReceiveText;
//                if ([messageBody.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
//                    messageBody = @"[动画表情]";
//                }
                NSLog(@"id:%@, 未读:%d  时间:%@  最后一条:%@", _conversation.conversationId, _conversation.unreadMessagesCount, self.time.text, textBody.text);
            }
        }else if (messageBody.type == EMMessageBodyTypeVoice){
            self.message.text = @"[语音]";
        }else if (messageBody.type == EMMessageBodyTypeImage){
                            self.message.text = @"[图片]";
        }else{
            self.message.text = @"[表情]";
        }
    }
}

- (void)setModel:(IMListModel *)model
{
    if (_model != model) {
        _model = model;
    }
//    [self.image setImageWithURL:[NSURL URLWithString:self.model.head_pic] refreshCache:YES placeholderImage:ZHANWEI];
    [self.image sd_setImageWithURL:WZWURLWithString(model.head_pic) placeholderImage:ZHANWEI];
    
//    self.image.image = ZHANWEI;
    self.meowID.text = self.model.real_name;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
