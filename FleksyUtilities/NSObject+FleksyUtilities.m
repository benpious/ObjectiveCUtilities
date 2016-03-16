//
//  NSObject+Fleksy.m
//  FleksyiOS
//
//  Created by Ben Pious on 11/13/15.
//  Copyright © 2015 Fleksy, Inc. All rights reserved.
//

#import "NSObject+FleksyUtilities.h"
#import <objc/runtime.h>

@implementation NSObject (Fleksy)

+ (instancetype)ifIsKindOfClass:(id)instance {
  return [instance isKindOfClass:self] ? instance : nil;
}

@end
