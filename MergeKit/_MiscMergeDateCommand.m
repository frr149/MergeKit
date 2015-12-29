//
//  _MiscMergeDateCommand.m
//
//	Written by Don Yacktman and Carl Lindberg
//
//	Copyright 2001-2004 by Don Yacktman and Carl Lindberg.
//	All rights reserved.
//
//      This notice may not be removed from this source code.
//
//	This header is included in the MiscKit by permission from the author
//	and its use is governed by the MiscKit license, found in the file
//	"License.rtf" in the MiscKit distribution.  Please refer to that file
//	for a list of all applicable permissions and restrictions.
//	

@import Foundation;
#import "_MiscMergeDateCommand.h"
#import <Foundation/NSObjCRuntime.h>

@class NSCalendarDate;

@implementation _MiscMergeDateCommand


- (BOOL)parseFromScanner:(NSScanner *)aScanner template:(MiscMergeTemplate *)template
{
    [self eatKeyWord:@"date" fromScanner:aScanner isOptional:NO];
    dateFormat = [self getArgumentStringFromScanner:aScanner toEnd:YES];
    if ([dateFormat length] == 0)
        dateFormat = @"%B %d, %Y";


    return YES;
}

- (MiscMergeCommandExitType)executeForMerge:(MiscMergeEngine *)aMerger
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = dateFormat;
    [aMerger appendToOutput:[fmt stringFromDate:currentDate]];
    return MiscMergeCommandExitNormal;
}

@end
