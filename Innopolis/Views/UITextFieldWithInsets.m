//
//  UITextFieldWithInsets.m
//  moshelper
//
//  Created by Programming Product on 26.06.14.
//  Copyright (c) 2014 Programming Product. All rights reserved.
//

#import "UITextFieldWithInsets.h"

static CGFloat _offset = 20;

@implementation UITextFieldWithInsets

- (id) initWithFrame:(CGRect)frame andOffset:(CGFloat) offset{
    _offset = offset;
    self = [self initWithFrame:frame];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/// the text field’s text
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectOffset( bounds , _offset , 3);
}

/// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectOffset( bounds , _offset , 3);
}

/// placeholder rect
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectOffset( bounds , _offset , 3);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
