//
//  RFToolbarButton.m
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFToolbarButton.h"

@implementation RFToolbarButton

static UITextView *textView = NULL;
static UITextField *textField = NULL;

- (id)init
{
    CGSize sizeOfText = [[self titleForButton] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]}];
    
    self = [super initWithFrame:CGRectMake(0, 0, sizeOfText.width + 38.104, sizeOfText.height + 10.298)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
//        self.layer.cornerRadius = 3.0f;
//        self.layer.borderWidth = 1.0f;
//        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        
        [self setTitle:[self titleForButton] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        [self addTarget:self action:@selector(buttonTarget) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (void)setTextViewForButton:(UITextView*)textViewPassed {
    textView = textViewPassed;
}

+ (UITextView*)textView {
    return textView;
}

+ (void)setTextFieldForButton:(UITextField*)textFieldPassed {
    textField = textFieldPassed;
}

+ (UITextField*)textField {
    return textField;
}

- (NSString*)titleForButton {
    return nil;
}

-(void)buttonTarget {}

@end
