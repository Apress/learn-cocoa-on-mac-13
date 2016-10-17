//
//  ECAppDelegate.m
//  ExceptionCity
//
//  Created by Jack on 2/7/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import "ECAppDelegate.h"

@implementation ECAppDelegate

- (void)invalidArgumentException_unrecognizedSelector {
    // The downside of dynamism is the occasional type mismatch.
    // For instance, it's sometimes hard to be sure what's coming
    // out of an array.  Imagine this array is created somewhere...
    NSArray *nameComponents = @[@"Thurston",
                                @"Howell",
                                [NSNumber numberWithInt:3]];
    
    // ... and accessed later on, by code that just assumes all the
    // array's items are strings:
    NSInteger nameComponentLength = 0;
    for (NSString *component in nameComponents) {
        nameComponentLength += [component length];
    }
    NSLog(@"Total length of all name components: %ld",
          (long)nameComponentLength);
}

- (void)invalidArgumentException_insertNil {
    // Assuming we have an array to put things into...
    NSMutableArray *array = [NSMutableArray array];
    
    // ... we can add an object to it.
    id object1 = @"hello";
    [array addObject:object1];
    
    // But suppose we take a method parameter or instance variable
    // whose value we haven't checked to make sure it wasn't nil...
    id object2 = nil;
    
    // ... and try to add it to the array?
    [array addObject:object2];
    NSLog(@"inserted all the objects I could!");
}

- (void)rangeException {
    // Assuming we have an array of things...
    NSArray *array = @[@"one", @"two", @"three"];
    
    // ... we can ask for the index of an item...
    NSUInteger indexOfTwo = [array indexOfObject:@"two"];
    
    // ... and we can later retrieve that value using the same index.
    NSLog(@"found indexed item %@", array[indexOfTwo]);
    
    // But, what if we try to find the index for something that's not
    // there?
    NSUInteger indexOfFive = [array indexOfObject:@"five"];
    
    // And we forget to check the return value to make sure it's not
    // NSNotFound?
    NSLog(@"found indexed item %@", array[indexOfFive]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self fileError];
//    [self uninitializedObject];
    [self freedObject];
    [self invalidArgumentException_unrecognizedSelector];
    [self invalidArgumentException_insertNil];
    [self rangeException];
    NSRunAlertPanel(@"Success", @"Hooray, you fixed everything!",
                    nil, nil, nil);
}

- (void)uninitializedObject {
    NSMutableString *string = (__bridge NSMutableString *)(void *)0xdeadbeef;
    [string appendFormat:@"foo"];
}

- (void)freedObject {
    NSString *object = [[NSString alloc] initWithCString:"hi there"
                                                encoding:NSUTF8StringEncoding];
    [object release];
    object = nil;
    NSLog(@"Where is my object? %@", object);
}
 
/*
- (void)freedObject {
    //NSObject *object = [[NSObject alloc] init];
    NSString *object = [[NSString alloc] initWithCString:"hi there" encoding:NSUTF8StringEncoding];
    NSLog(@"This? %@", [object description]);
    void *tmp = (__bridge void *)object;
    __unsafe_unretained NSObject *another = (__bridge NSObject *)(tmp);
    //[object release];
    
    //CFRelease((__bridge CFTypeRef)(object));
    //object = nil;
    NSLog(@"Where is my object? %@", [another description]);
}
 */

- (void)fileError {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Declare a variable and point it at nil
    NSError *fileError = nil;
    
    // Pass the address of the fileError variable to the method
    NSDictionary *attributes = [fileManager
                                attributesOfItemAtPath:@"/tmpfoo" error:&fileError];
    
    // Check to see if the previous method call gave us an NSError
    if (fileError == nil) {
        // Show the attributes
        NSRunAlertPanel(@"Found file attributes",
                        [attributes description], nil, nil, nil);
    } else {
        // Report the error
        [NSApp presentError:fileError];
    }
}

@end
