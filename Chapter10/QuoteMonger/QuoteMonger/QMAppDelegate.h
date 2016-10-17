//
//  QMAppDelegate.h
//  QuoteMonger
//
//  Created by Peter Clark on 12/1/12.
//  Copyright (c) 2012 myself. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong) NSPredicate *searchPredicate;

- (IBAction)saveAction:(id)sender;

@end
