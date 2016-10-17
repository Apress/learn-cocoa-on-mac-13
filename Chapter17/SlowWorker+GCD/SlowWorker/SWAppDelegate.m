//
//  SWAppDelegate.m
//  SlowWorker
//
//  Created by Jack on 1/22/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import "SWAppDelegate.h"

@implementation SWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (NSString *)fetchSomethingFromServer {
    sleep(1);
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data {
    sleep(2);
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data {
    sleep(3);
    return [NSString stringWithFormat:@"Number of chars: %ld",
            [data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data {
    sleep(4);
    return [data stringByReplacingOccurrencesOfString:@"E"
                                           withString:@"e"];
}

- (IBAction)doWork:(id)sender {
    NSDate *startTime = [NSDate date];
    
    __block NSString *fetchedData;
    __block NSString *processed;
    __block NSString *firstResult;
    __block NSString *secondResult;

    self.isWorking = YES;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        fetchedData = [self fetchSomethingFromServer];
        dispatch_async(dispatch_get_main_queue(), ^{
            _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                       @"Fetched: %@\n", fetchedData];
        });
        
        processed = [self processData:fetchedData];
        dispatch_async(dispatch_get_main_queue(), ^{
            _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                       @"Processed: %@\n", processed];
        });
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            firstResult = [self calculateFirstResult:processed];
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            secondResult = [self calculateSecondResult:processed];
        });
        
        dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                           @"First Result: [%@]\nSecond Result: [%@]\n\n",
                                           firstResult, secondResult];
            });
            
            NSDate *endTime = [NSDate date];
            NSLog(@"Completed in %f seconds",
                  [endTime timeIntervalSinceDate:startTime]);
            self.isWorking = NO;
        });
    });
}

@end
