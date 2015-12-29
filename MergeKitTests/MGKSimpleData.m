//
//  MGKSimpleData.m
//  MergeKit
//
//  Created by Fernando Rodríguez Romero on 29/12/15.
//  Copyright © 2015 keepcoding.io. All rights reserved.
//

#import "MGKSimpleData.h"

@implementation MGKSimpleData

-(NSString*) name{
    return @"Chewbacca";
}

-(NSArray *) species{
    return @[@"human", @"wookie", @"hutt", @"Mon Calamari", @"ewok"];
}

-(NSInteger) salary{
    return 12900;
}
@end
