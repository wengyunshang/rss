//
//  WxxButton.m
//  DontTry
//
//  Created by weng xiangxun on 13-1-17.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import "WxxButton.h"

@interface WxxButton(){
}
@end

@implementation WxxButton

- (id)initWithPoint:(CGPoint)point imageName:(NSString*)imgname{
    
    UIImage *image = [UIImage imageNamed:imgname];
    self = [super initWithFrame:CGRectMake(point.x, point.y, image.size.width, image.size.height)];
    if (self) {
        // Initialization code
        //        self.titleLabel.textColor = TextColor;
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(UIImage*)image{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        self.titleLabel.textColor = TextColor;
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


// touchSize 点击扩大热区， 由于按钮图片太小，需要扩大点击热区
- (id)initWithPoint:(CGPoint)point image:(NSString*)imageName touchSize:(float)size{
    UIImage *image = [UIImage imageNamed:imageName];
    
    self = [super initWithFrame:CGRectMake(point.x-size/2, point.y-size/2, image.size.width+size, image.size.height+size)];
    if (self) {
        // Initialization code
//        self.image = image;
        [self setImage:image forState:UIControlStateNormal];
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor font:(int)font touchSize:(float)size{
    
    self = [super initWithFrame:CGRectMake(frame.origin.x-size/2, frame.origin.y-size/2, frame.size.width+size, frame.size.height+size)];
    if (self) {
        // Initialization code
        
        [self setTitle:title forState:UIControlStateNormal];
        //        self.titleLabel.textColor = textColor;
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:font];;
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title border:(BOOL)ynborder borderColor:(UIColor*)bordercolor textColor:(UIColor *)textColor font:(int)font{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (ynborder) {
            self.layer.borderWidth = 1;
            self.layer.borderColor = [bordercolor CGColor];
            self.layer.cornerRadius = 2;
            self.layer.masksToBounds = YES;
        }
        
        [self setTitle:title forState:UIControlStateNormal];
        //        self.titleLabel.textColor = textColor;
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:font];;
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor font:(int)font{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setTitle:title forState:UIControlStateNormal];
//        self.titleLabel.textColor = textColor;
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:font];;
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor uifont:(UIFont*)uifont{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setTitle:title forState:UIControlStateNormal];
                self.titleLabel.textColor = textColor;
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.font = uifont;;
        [self addTarget:self action:@selector(touchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setBottomLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    line.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
    [self addSubview:line];
}


-(void)touchBtn{
    if (self.btnTouch) {
        self.btnTouch();
    }
}
@end
