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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  The `JSQMessageServerMessageActionButtonDataSource` protocol defines the common interface through which
 *  a `JSQMessagesViewController` and `JSQMessagesCollectionView` interact with 
 *  server message action button model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances
 *  of that class can be display properly within a `JSQMessagesCollectionViewCellServerMessage`.
 *
 *  A concrete class that conforms to this protocol is provided in the library. See `JSQMessageServerMessageActionButton`.
 *
 *  @see JSQMessageServerMessageActionButton.
 */
@protocol JSQMessageServerMessageActionButtonDataSource <NSObject>

@optional

/**
 *  @return The server message action button for a regular display state.
 *
 *  @warning You must not return `nil` from this method.
 */
@property (nonatomic, strong, readonly) UIButton *actionButton;

@end
