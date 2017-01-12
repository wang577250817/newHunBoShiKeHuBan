//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LPlaceholderTextView.h"


@implementation LPlaceholderTextView


#pragma mark - init & dealloc


- (void)shiquxiangying
{
    [self resignFirstResponder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (void)topShow
{
    [_placeholderLabel setVerticalAlignment:VerticalAlignmentTop];
}
- (void)initialize
{
    _placeholderColor = [UIColor lightGrayColor];
    [self layoutGUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notification center


- (void)textChanged:(NSNotification *)notification
{
    if (notification.object == self)
        [self layoutGUI];
}


#pragma mark - layoutGUI


- (void)layoutGUI
{
    _placeholderLabel.alpha = [self.text length] > 0 || [_placeholderText length] == 0 ? 0 : 1;
}


#pragma mark - Setters


- (void)setText:(NSString *)text
{
    [super setText:text];
    [self layoutGUI];
}


- (void)setPlaceholderText:(NSString*)placeholderText
{
	_placeholderText = placeholderText;
	[self setNeedsDisplay];
}


- (void)setPlaceholderColor:(UIColor*)color
{
	_placeholderColor = color;
	[self setNeedsDisplay];
}


#pragma mark - drawRect


- (void)drawRect:(CGRect)rect
{
    if ([_placeholderText length] > 0)
    {
        if (!_placeholderLabel)
        {
            _placeholderLabel = [[MyLabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeholderLabel.numberOfLines = 0;
            _placeholderLabel.font = FONT(14);
            _placeholderLabel.backgroundColor = [UIColor clearColor];
            _placeholderLabel.alpha = 0;

            [self addSubview:_placeholderLabel];
        }
        
        _placeholderLabel.text = _placeholderText;
        _placeholderLabel.textColor = _placeholderColor;
        [_placeholderLabel sizeToFit];
        [self sendSubviewToBack:_placeholderLabel];
    }
    
    [self layoutGUI];
    
    [super drawRect:rect];
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
// replacementText:(NSString *)text {
//    //内容（滚动视图）高度大于一定数值时
//    if (textView.contentSize.height >60)
//    {
//        //删除最后一行的第一个字符，以便减少一行。
//        textView.text = [textView.textsubstringToIndex:[textView.textlength]-1];
//        return NO;
//    }
//    
//    return YES;
//}

#pragma mark -


@end