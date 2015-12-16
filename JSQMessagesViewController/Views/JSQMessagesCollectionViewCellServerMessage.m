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

#import "JSQMessagesCollectionViewCellServerMessage.h"

@interface JSQMessagesCollectionViewCellServerMessage ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet JSQMessagesCellTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *statusViewContainer;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *actionViewContainer;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation JSQMessagesCollectionViewCellServerMessage

static NSMutableSet *jsqMessagesCollectionViewCellActions = nil;

#pragma mark - Class methods

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsqMessagesCollectionViewCellActions = [NSMutableSet new];
    });
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerMenuAction:(SEL)action
{
    [jsqMessagesCollectionViewCellActions addObject:NSStringFromSelector(action)];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.textView.textAlignment = NSTextAlignmentCenter;
    self.textView.font = [UIFont boldSystemFontOfSize:14.0f];
    self.textView.textColor = [UIColor lightGrayColor];
    
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont systemFontOfSize:16.0f];
    self.statusLabel.textColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleTapGesture:)];
    [self addGestureRecognizer:tap];
    self.tapGestureRecognizer = tap;
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.textView.text = nil;
    self.textView.attributedText = nil;
    
    [self setStatusLabelText:nil];
    self.actionView = nil;
    
    self.topImageViewHeightConstraint.constant = 20.f;
    self.bottomImageViewHeightConstraint.constant = 20.f;
}

#pragma mark - Menu actions

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return YES;
    }
    
    return [super respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(anInvocation.selector)]) {
        __unsafe_unretained id sender;
        [anInvocation getArgument:&sender atIndex:0];
        [self.delegate messagesCollectionViewCellServerMessage:self didPerformAction:anInvocation.selector withSender:sender];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.topImageView.backgroundColor = backgroundColor;
    self.textView.backgroundColor = backgroundColor;
    self.statusViewContainer.backgroundColor = backgroundColor;
    self.statusLabel.backgroundColor = backgroundColor;
    self.actionViewContainer.backgroundColor = backgroundColor;
    self.bottomImageView.backgroundColor = backgroundColor;
}

- (void)setStatusLabelText:(NSAttributedString *)text
{
    self.statusLabel.attributedText = text;
    if (text) {
        self.statusViewHeightConstraint.constant = 50.f;
    }
    else {
        self.statusViewHeightConstraint.constant = 0.f;
    }
}

- (void)setActionView:(UIView *)actionView
{
    if (_actionView) {
        [_actionView removeFromSuperview];
    }
    
    if (actionView) {
        self.actionViewHeightConstraint.constant = 50.f;
        [self.actionViewContainer addSubview:actionView];
        [self applyAutolayoutToActionView:actionView container:self.actionViewContainer];
    }
    else {
        self.actionViewHeightConstraint.constant = 0.f;
    }
    
    _actionView = actionView;
}

#pragma mark - Gesture recognizers

- (void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGPoint touchPt = [tap locationInView:self];
    [self.delegate messagesCollectionViewCellServerMessageDidTapCell:self atPosition:touchPt];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self];
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.textView.frame, touchPt);
    }
    
    return YES;
}

#pragma mark - Private

- (void)applyAutolayoutToActionView:(UIView *)view container:(UIView *)container
{
    if (view.translatesAutoresizingMaskIntoConstraints) {
        CGFloat width = CGRectGetWidth(view.frame);
        CGFloat height = CGRectGetHeight(view.frame);
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.f
                                                          constant:width]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.f
                                                          constant:height]];
    }
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

@end
