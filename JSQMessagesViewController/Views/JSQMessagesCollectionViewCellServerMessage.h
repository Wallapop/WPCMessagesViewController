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

#import <UIKit/UIKit.h>

#import "JSQMessagesLabel.h"
#import "JSQMessagesCellTextView.h"

@class JSQMessagesCollectionViewCellServerMessage;

/**
 *  The `JSQMessagesCollectionViewCellDelegate` protocol defines methods that allow you to manage
 *  additional interactions within the collection view cell.
 */
@protocol JSQMessagesCollectionViewCellDelegate <NSObject>

@required

/**
 *  Tells the delegate that the cell has been tapped at the point specified by position.
 *
 *  @param cell The cell that received the tap touch event.
 *  @param position The location of the received touch in the cell's coordinate system.
 *
 *  @see `JSQMessagesCollectionViewCellServerMessage`
 */
- (void)messagesCollectionViewCellDidTapCell:(JSQMessagesCollectionViewCellServerMessage *)cell atPosition:(CGPoint)position;

/**
 *  Tells the delegate that the action view of the cell has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */
- (void)messagesCollectionViewCellDidTapActionView:(JSQMessagesCollectionViewCellServerMessage *)cell;

/**
 *  Tells the delegate that an actions has been selected from the menu of this cell.
 *  This method is automatically called for any registered actions.
 *
 *  @param cell The cell that displayed the menu.
 *  @param action The action that has been performed.
 *  @param sender The object that initiated the action.
 *
 *  @see `JSQMessagesCollectionViewCellServerMessage`
 */
- (void)messagesCollectionViewCell:(JSQMessagesCollectionViewCellServerMessage *)cell didPerformAction:(SEL)action withSender:(id)sender;

@end

@interface JSQMessagesCollectionViewCellServerMessage : UICollectionViewCell

/**
 *  The object that acts as the delegate for the cell.
 */
@property (weak, nonatomic) id<JSQMessagesCollectionViewCellDelegate> delegate;

/**
 *  The top dots view of the cell. This view displays an image of 2 dots to separate server messages.
 */
@property (weak, nonatomic, readonly) UIView *topDotsView;

/**
 *  Returns the text view of the cell. This text view contains the message body text.
 */
@property (weak, nonatomic, readonly) JSQMessagesCellTextView *textView;

/**
 *  The status view of the cell. This view displays a label to show separated info.
 */
@property (weak, nonatomic, readonly) JSQMessagesLabel *statusLabel;

/**
 *  The button view of the cell. This view displays (optionally) a view with a button.
 */
@property (weak, nonatomic, readwrite) UIView *actionButton;

/**
 *  The bottom dots view of the cell. This view displays an image of 2 dots to separate server messages.
 */
@property (weak, nonatomic, readonly) UIView *bottomDotsView;

/**
 *  TODO
 */
- (void)setStatusLabelText:(NSAttributedString *)text;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for the cell.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify a reusable cell for server message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)cellReuseIdentifier;

/**
 *  Registers an action to be available in the cell's menu.
 *
 *  @param action The selector to register with the cell.
 *
 *  @discussion Non-standard or non-system actions must be added to the `UIMenuController` manually.
 *  You can do this by creating a new `UIMenuItem` and adding it via the controller's `menuItems` property.
 *
 *  @warning Note that all message cells share the all actions registered here.
 */
+ (void)registerMenuAction:(SEL)action;

@end
