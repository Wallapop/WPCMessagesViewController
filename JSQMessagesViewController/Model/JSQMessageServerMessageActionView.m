//
//  Created by Luis Ascorbe
//  https://twitter.com/Lascorbe
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessageServerMessageActionView.h"

@interface JSQMessageServerMessageActionView ()
@property (nonatomic) UIView *actionView;
@end

@implementation JSQMessageServerMessageActionView

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        _actionView = view;
    }
    return self;
}

@end
