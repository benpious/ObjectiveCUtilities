//
//  NSObject+Fleksy.h
//  FleksyiOS
//
//  Created by Ben Pious on 11/13/15.
//  Copyright © 2015 Fleksy, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Fleksy)

/**
 @returns instance if instance returns YES from -isKindOfClass: with the receiver as the argument
 */
+ (instancetype)ifIsKindOfClass:(id)instance;

@end
