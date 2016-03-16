//
//  NSArray+HigherOrderMessaging.m
//  HOMTest
//
//  Created by Benjamin Pious on 7/7/15.
//  Copyright (c) 2015 benpious. All rights reserved.
//

#import "NSArray+FleksyUtilities.h"

#pragma mark - Interfaces

@interface NSInvocation (Fleksy_ObjectReturnValue)

- (id)fly_objectReturnValue;

@end

@interface FLYArrayProxy : NSProxy

- (instancetype)initWithTarget:(NSArray *)target;
@property (nonatomic) NSArray *target;

@end

@interface FLYApplyProxy : FLYArrayProxy

@end

#pragma mark - Implementations

@implementation NSArray (Fleksy_HigherOrderMessaging)

- (id)apply {
  return self.count ? [[FLYApplyProxy alloc] initWithTarget:self] : nil;
}

@end

@implementation FLYArrayProxy

- (instancetype)initWithTarget:(NSArray *)target {
  self.target = target;
  return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
  return [self.target.firstObject methodSignatureForSelector:aSelector];
}

@end

@implementation FLYApplyProxy

- (void)forwardInvocation:(NSInvocation *)invocation {
  for (id obj in self.target) {
    [invocation invokeWithTarget:obj];
  }
}

@end

@implementation NSInvocation (Fleksy_ObjectReturnValue)

- (id)fly_objectReturnValue {
  __unsafe_unretained id result;
  [self getReturnValue:&result];
  return result;
}

@end

@implementation NSArray (Fleksy_FunctionalUtilities)

- (NSArray *)fly_flatten {
  NSMutableArray *r = [NSMutableArray array];
  for (id o in self) {
    if ([o isKindOfClass:[NSArray class]]) {
      [r addObjectsFromArray:[o fly_flatten]];
    }
    else {
      [r addObject:o];
    }
  }
  return [NSArray arrayWithArray:r];
}

- (NSDictionary *)fly_divideIntoBuckets:(id (^)(id o))bucketKeyProvider {
  NSMutableDictionary *d = [NSMutableDictionary dictionary];
  for (id o in self) {
    id key = bucketKeyProvider(o);
    NSMutableArray *a = d[key];
    if (!a) {
      a = [NSMutableArray array];
      d[key] = a;
    }
    [a addObject:o];
  }
  return d;
}

- (NSArray *)fly_shuffled {
  NSMutableArray *e = self.mutableCopy;
  NSMutableArray *r = [NSMutableArray array];
  while (e.count) {
    NSUInteger i = (NSUInteger)arc4random_uniform((uint32_t)e.count);
    id o = e[i];
    [e removeObjectAtIndex:i];
    [r addObject:o];
  }
  return r;
}

- (instancetype)fly_filter:(BOOL (^)(__kindof id))predicate {
  NSMutableArray *array = [NSMutableArray array];
  for (id obj in self) {
    if (predicate(obj)) {
      [array addObject:obj];
    }
  }
  return [NSArray arrayWithArray:array];
}

- (BOOL)fly_exists:(BOOL (^)(__kindof id))predicate {
  return [self fly_filter:predicate].count ? YES : NO;
}

- (NSArray *)fly_map:(id (^)(__kindof id))f {
  NSMutableArray *result = [NSMutableArray array];
  for (id obj in self) {
    id r = f(obj);
    if (r) {
      [result addObject:r];
    }
  }
  return result;
}

@end
