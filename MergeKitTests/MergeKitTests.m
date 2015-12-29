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




@end
