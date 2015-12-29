//
//  MergeKitTests.m
//  MergeKitTests
//
//  Created by Fernando Rodríguez Romero on 29/12/15.
//  Copyright © 2015 keepcoding.io. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MiscMergeTemplate.h"
#import "MiscMergeEngine.h"

#import "MGKSimpleData.h"

@interface MergeKitTests : XCTestCase
@property (strong, nonatomic, readonly) MiscMergeTemplate *simpleTemplate;
@property (strong, nonatomic, readonly) MiscMergeTemplate *foreachTemplate;
@property (strong, nonatomic, readonly) MiscMergeTemplate *ifTemplate;
@end

@implementation MergeKitTests

-(MiscMergeTemplate*) simpleTemplate{
   
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [testBundle URLForResource:@"Test" withExtension:@"txt"];
    
    MiscMergeTemplate *tpl = [[MiscMergeTemplate alloc] init];
    [tpl setStartDelimiter:@"<$" endDelimiter:@"$>"];
    [tpl setFilename:url.path];
    [tpl parseString:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
    return tpl;
}

-(MiscMergeTemplate *) foreachTemplate{
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [testBundle URLForResource:@"Foreach" withExtension:@"md"];
    
    MiscMergeTemplate *tpl = [[MiscMergeTemplate alloc] init];
    [tpl setStartDelimiter:@"{" endDelimiter:@"}"];
    [tpl setFilename:url.path];
    [tpl parseString:@"({foreach elt species test}{elt}:{eltIndex}, {endforeach test})"];
    return tpl;
}

-(MiscMergeTemplate *) ifTemplate{
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [testBundle URLForResource:@"Foreach" withExtension:@"md"];
    
    MiscMergeTemplate *tpl = [[MiscMergeTemplate alloc] init];
    [tpl setStartDelimiter:@"[" endDelimiter:@"]"];
    [tpl setFilename:url.path];
    [tpl parseString:@"You qualify for a Visa [if salary > 35000]Gold[else]Classic[endif] card!"];
    return tpl;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}

-(void) testCreateSimpleTemplate{

    XCTAssertNotNil(self.simpleTemplate);
    
}

-(void) testSimpleEngine{
    
    MiscMergeEngine *eng = [[MiscMergeEngine alloc] initWithTemplate:self.simpleTemplate];
    
    XCTAssertNotNil(eng);
    
}
-(void) testSimpleMerge{
    
    MGKSimpleData *data = [MGKSimpleData new];
    
    MiscMergeEngine *eng = [[MiscMergeEngine alloc] initWithTemplate:self.simpleTemplate];
    [eng setMainObject:data];
    NSString *res = [eng execute:nil];
    
    XCTAssertNotNil(res);
    
}

-(void) testMergeNilData{
    
    MiscMergeEngine *eng = [[MiscMergeEngine alloc] initWithTemplate:self.simpleTemplate];

    NSString *res = [eng execute:nil];

    XCTAssertEqualObjects(res, @"This is my first template for name.");
}

-(void) testForEachCommand{
    
    MiscMergeEngine *eng = [[MiscMergeEngine alloc] initWithTemplate:self.foreachTemplate];
    [eng setMainObject:[MGKSimpleData new]];
    NSString *res = [eng execute:nil];
    
    XCTAssertEqualObjects(res, @"(human:0, wookie:1, hutt:2, Mon Calamari:3, ewok:4, )");
    
    
}

-(void) testIfCommand{
    
    MiscMergeEngine *eng = [[MiscMergeEngine alloc] initWithTemplate:self.ifTemplate];
    [eng setMainObject:[MGKSimpleData new]];
    NSString *res = [eng execute:nil];
    
    XCTAssertEqualObjects(res, @"You qualify for a Visa Classic card!");
    
}

-(void) testThatInitializingATemplateWithAFileDoesntReturnNil{
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [testBundle URLForResource:@"Test" withExtension:@"txt"];
    
    MiscMergeTemplate *tpl = [[MiscMergeTemplate alloc] initWithContentsOfFile:url.path];
    
    XCTAssertNotNil(tpl);
    

}

@end
