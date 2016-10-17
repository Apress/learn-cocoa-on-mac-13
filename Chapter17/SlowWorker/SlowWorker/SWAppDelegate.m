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
    
    NSString *fetchedData;
    NSString *processed;
    NSString *firstResult;
    NSString *secondResult;

    self.isWorking = YES;
    
    fetchedData = [self fetchSomethingFromServer];
    _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                               @"Fetched: %@\n", fetchedData];
    
    processed = [self processData:fetchedData];
    _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                               @"Processed: %@\n", processed];
    
    firstResult = [self calculateFirstResult:processed];
    secondResult = [self calculateSecondResult:processed];    
    _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                               @"First Result: [%@]\nSecond Result: [%@]\n\n",
                               firstResult, secondResult];

    NSDate *endTime = [NSDate date];
    NSLog(@"Completed in %f seconds",
          [endTime timeIntervalSinceDate:startTime]);
    self.isWorking = NO;
}

@end
