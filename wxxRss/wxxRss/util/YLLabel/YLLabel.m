//
//  YLLabel.m
//  YLLabelDemo
//
//  Created by Eric Yuan on 12-11-8.
//  Copyright (c) 2012年 YuanLi. All rights reserved.
//

#import "YLLabel.h"
#import <CoreText/CoreText.h>
#import "NSString+wxx.h"
//#import "BlackView.h"
//#import <UIKit/UIKit.h>
@interface YLLabel(Private)

- (void)formatString;

@end

@implementation YLLabel

@synthesize font = _font;
@synthesize textColor = _textColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self formatString];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);

    CGContextTranslateCTM(ctx,0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_string);
    
    CGRect bounds = self.bounds;
    bounds.origin.x = bounds.origin.x;
    bounds.size.width = bounds.size.width;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [_string length]), path, NULL);
    
    CFRelease(path);
    
    CTFrameDraw(frame, ctx);
    CFRelease(frame);
    CFRelease(frameSetter);
}

- (void)setText:(NSString *)text
{
    _string = [[NSMutableAttributedString alloc] initWithString:text];
    [self setNeedsDisplay];
}

//-(void)showDisplay{
//    [self setNeedsDisplay];
//}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setNeedsDisplay];
}

- (void)formatString
{
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    
    CGFloat paragraphSpacing = 0.0;
    CGFloat paragraphSpacingBefore = 0.0;
    CGFloat firstLineHeadIndent = 0.0;
    CGFloat headIndent = 0.0;
    CGFloat lineSp = 0.0;
    CTParagraphStyleSetting settings[] =
    {
        {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &firstLineHeadIndent},
        {kCTParagraphStyleSpecifierHeadIndent, sizeof(CGFloat), &headIndent},
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &paragraphSpacingBefore},
        {kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSp},
    };
    
    CTParagraphStyleRef style;
    style = CTParagraphStyleCreate(settings, sizeof(settings)/sizeof(CTParagraphStyleSetting));
    
    if (NULL == style) {
        // error...
        return;
    }

    [_string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge NSObject*)style, (NSString*)kCTParagraphStyleAttributeName, nil]
                     range:NSMakeRange(0, [_string length])];

    CFRelease(style);
//    NSLog(@"%d",[_string length]);
    if (nil == _font) {
        _font = [UIFont boldSystemFontOfSize:12.0];
    }

    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
    [_string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge NSObject*)fontRef, (NSString*)kCTFontAttributeName, nil]
                     range:NSMakeRange(0.9, [_string length])];
    
    CGColorRef colorRef = _textColor.CGColor;
    [_string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge NSObject*)colorRef,(NSString*)kCTForegroundColorAttributeName, nil]
                     range:NSMakeRange(0, [_string length])];
    
//    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)_font.fontName, _font.pointSize, NULL);
//    [_string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge NSObject*)fontRef, (NSString*)kCTFontAttributeName, nil]
//                     range:NSMakeRange(0.9, [_string length])];
//    if (!_textColor) {
//        _textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0];
//    }
//    CGColorRef colorRef = _textColor.CGColor;
//    [_string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge NSObject*)colorRef,(NSString*)kCTForegroundColorAttributeName, nil]
//                     range:NSMakeRange(0, [_string length])];
}

-(void)resetFrame{
    
    CGRect rect = self.frame;
    rect.size.height = [self highHeight];
    self.frame = rect;
//    [BlackView sizeHeightAnimation:self sizeH:height];
    [self setNeedsDisplay];
}

-(float)highHeight{

    CGSize labelsize = [[self.string string] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame),2000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName : self.font}
                                               context:nil].size;
    
    labelsize.height = labelsize.height + labelsize.height/self.font.xHeight*2;
    return labelsize.height;
}


@end
