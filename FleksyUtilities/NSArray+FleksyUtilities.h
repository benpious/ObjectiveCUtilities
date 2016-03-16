//
//  NSArray+HigherOrderMessaging.h
//  HOMTest
//
//  Created by Benjamin Pious on 7/7/15.
//  Copyright (c) 2015 benpious. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant T> (Fleksy_HigherOrderMessaging)
/*
 Category implemeting Higher order messaging features on NSArray.
 
 Example usage:
 
 [[arrayOfUIButtons apply] setBackGroundColor:[UIColor clearColor]];
 */

/**
 Returns a trampoline object, which applies messages to every object in the original receiver.
 @note intented to be used with functions that return (void). It is not possible to capture rvalues from the functions you apply.
 */
- (T)apply;

@end

@interface NSArray<__covariant T> (Fleksy_FunctionalUtilities)
/**
 A set of functional style functions for NSArray
 */

/**
 @returns an array of objects passing the predicate
 */
- (instancetype)fly_filter:(BOOL (^)(__kindof T p))predicate;
- (BOOL)fly_exists:(BOOL (^)(__kindof T p))predicate;
/**
 @param f a function to apply to all elements in the receiver
 @returns the result of running f on all elements in the array
 */
- (NSArray *)fly_map:(id (^)(__kindof T o))f;

/**
 @returns an array with all subarrays recursively flattened
 */
- (NSArray *)fly_flatten;
/**
 Divides the array into buckets
 @param bucketKeyProvider visits each member of the receiver -- returns the object that should be used as the key in the array for that object (usually a property of that object)
 @returns an dictionary whose keys are the results returned from the bucketKeyProvider for each object, and whose values are arrays of the values that correspond to that key
 */
- (NSDictionary<id, T> *)fly_divideIntoBuckets:(id (^)(T o))bucketKeyProvider;
/**
 @returns an array whose values have been re-ordered randomly
 */
- (NSArray<T> *)fly_shuffled;

@end

@interface NSArray<__covariant T> (IndexPathSearch)

- (NSIndexPath *)fly_indexPathOfObjectPassingTest:(BOOL (^)(T o))test;
- (NSArray *)fly_arrayByRemovingObjectAtIndexPath:(NSIndexPath *)p;

@end
