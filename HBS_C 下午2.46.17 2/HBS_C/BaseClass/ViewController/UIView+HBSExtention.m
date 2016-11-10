//
//  UIView+HBSExtention.m
//  HBS_C
//
//  Created by 王 世江 on 16/10/30.
//  Copyright © 2016年 wangzuowen. All rights reserved.
//

#import "UIView+HBSExtention.h"

@implementation UIView (HBSExtention)
- (CGSize)WSJ_size{
    return self.frame.size;
}
- (void)setWSJ_size:(CGSize)WSJ_size{
    
    CGRect frame = self.frame;
    frame.size = WSJ_size;
    self.frame = frame;
}
- (CGFloat)WSJ_width{
    
    return self.frame.size.width;
}
- (CGFloat)WSJ_height{
    
    return self.frame.size.height;
}
- (void)setWSJ_width:(CGFloat)WSJ_width{
    
    CGRect frame = self.frame;
    frame.size.width = WSJ_width;
    self.frame = frame;
}

- (void)setWSJ_height:(CGFloat)WSJ_height{
    
    CGRect frame = self.frame;
    frame.size.height = WSJ_height;
    self.frame = frame;
    
}
- (CGFloat)WSJ_x{
    
    return self.frame.origin.x;
}
- (void)setWSJ_x:(CGFloat)WSJ_x{
    
    CGRect frame = self.frame;
    frame.origin.x = WSJ_x;
    self.frame = frame;
    
}
- (CGFloat)WSJ_y{
    
    return self.frame.origin.y;
}
- (void)setWSJ_y:(CGFloat)WSJ_y{
    
    CGRect frame = self.frame;
    frame.origin.y = WSJ_y;
    self.frame = frame;
    
}

- (CGFloat)WSJ_centerX{
    
    return self.center.x;
}
- (void)setWSJ_centerX:(CGFloat)WSJ_centerX{
    
    CGPoint center = self.center;
    center.x = WSJ_centerX;
    self.center = center;
    
}

- (CGFloat)WSJ_centerY{
    
    return self.center.y;
}
- (void)setWSJ_centerY:(CGFloat)WSJ_centerY{
    
    CGPoint center = self.center;
    center.y = WSJ_centerY;
    self.center = center;
}
- (CGFloat)WSJ_right{
    
    //    return self.WSJ_x + self.WSJ_width;
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)WSJ_bottom{
    
    //    return self.WSJ_y + self.WSJ_height;
    return CGRectGetMaxY(self.frame);
}
- (void)setWSJ_right:(CGFloat)WSJ_right{
    
    self.WSJ_x = WSJ_right - self.WSJ_width;
}
- (void)setWSJ_bottom:(CGFloat)WSJ_bottom{
    
    self.WSJ_y = WSJ_bottom - self.WSJ_height;
}

@end
