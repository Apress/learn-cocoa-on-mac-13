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
    [self incrementCompleted];
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data {
    sleep(2);
    [self incrementCompleted];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data {
    sleep(3);
    [self incrementCompleted];
    return [NSString stringWithFormat:@"Number of chars: %ld",
            [data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data {
    sleep(4);
    [self incrementCompleted];
    return [data stringByReplacingOccurrencesOfString:@"E"
                                           withString:@"e"];
}

- (IBAction)doWork:(id)sender {
    self.completed = 0;
    
    NSDate *startTime = [NSDate date];
    
    __block NSString *fetchedData;
    __block NSString *processed;
    __block NSString *firstResult;
    __block NSString *secondResult;
    
    self.isWorking = YES;
    
    NSBlockOperation *fetch = [NSBlockOperation blockOperationWithBlock:^{
        fetchedData = [self fetchSomethingFromServer];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                       @"Fetched: %@\n", fetchedData];
        }];
    }];
    
    NSBlockOperation *process = [NSBlockOperation blockOperationWithBlock:^{
        processed = [self processData:fetchedData];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                       @"Processed: %@\n", processed];
        }];
    }];
    
    NSBlockOperation *calcFirst = [NSBlockOperation blockOperationWithBlock:^{
        firstResult = [self calculateFirstResult:processed];
    }];
    
    NSBlockOperation *calcSecond = [NSBlockOperation blockOperationWithBlock:^{
        secondResult = [self calculateSecondResult:processed];
    }];
    NSBlockOperation *showResults = [NSBlockOperation blockOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _resultsTextView.string = [_resultsTextView.string stringByAppendingFormat:
                                       @"First Result: [%@]\nSecond Result: [%@]\n\n",
                                       firstResult, secondResult];

            NSDate *endTime = [NSDate date];
            NSLog(@"Completed in %f seconds",
                  [endTime timeIntervalSinceDate:startTime]);
            self.isWorking = NO;
        }];
    }];
    
    [process addDependency:fetch];
    [calcFirst addDependency:process];
    [calcSecond addDependency:process];
    [showResults addDependency:calcFirst];
    [showResults addDependency:calcSecond];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [queue addOperations:@[fetch, process, calcFirst, calcSecond, showResults]
       waitUntilFinished:NO];
}

- (void)incrementCompleted {
    @synchronized(self) {
        self.completed = self.completed + 1;
    }
}

@end
