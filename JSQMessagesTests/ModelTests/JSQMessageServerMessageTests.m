//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessage.h"


@interface JSQMessageServerMessageTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) JSQMessageKind messageKind;

@end


@implementation JSQMessageServerMessageTests

- (void)setUp
{
    [super setUp];
    
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Wallapop";
    self.date = [NSDate date];
    
    self.text = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
    @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
    @"architecto beatae vitae dicta sunt explicabo.";
    
    self.messageKind = JSQMessageKindServerMessage;
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    self.text = nil;
    self.messageKind = JSQMessageKindMedia;
    [super tearDown];
}

#pragma mark - Text messages

- (void)testTextMessageInit
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text
                                                      kind:self.messageKind];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testTextMessageInvalidInit
{
    XCTAssertThrows([[JSQMessage alloc] init], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil text:nil kind:JSQMessageKindServerMessage], @"Invalid init should throw");
}

- (void)testTextMessageIsEqual
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text
                                                      kind:self.messageKind];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testTextMessageArchiving
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text
                                                      kind:self.messageKind];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
