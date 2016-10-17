//
//  VillainTrackerAppDelegate.m
//  VillainTracker
//
//  Created by Peter Clark on 6/19/12.
//  Copyright (c) 2012 Learn Cocoa. All rights reserved.
//

#define kName @"name"
#define kLastKnownLocation @"lastKnownLocation"
#define kLastSeenDate @"lastSeenDate"
#define kSwornEnemy @"swornEnemy"
#define kPrimaryMotivation @"primaryMotivation"
#define kPowers @"powers"
#define kPowerSource @"powerSource"
#define kEvilness @"evilness"
#define kMugshot @"mugshot"
#define kNotes @"notes"


#import "VillainTrackerAppDelegate.h"

@implementation VillainTrackerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.villain = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                    @"Lex Luthor", kName,
                    @"Smallville", kLastKnownLocation,
                    [NSDate date], kLastSeenDate,
                    @"Superman", kSwornEnemy,
                    @"Revenge", kPrimaryMotivation,
                    [NSArray arrayWithObjects:@"Evil Genius", nil], kPowers,
                    @"Superhero action", kPowerSource,
                    @9, kEvilness,
                    [NSImage imageNamed:@"NSUser"], kMugshot,
                    @"", kNotes,
                    nil];
    
    self.villains = [NSMutableArray arrayWithObject:self.villain];
    [self.villainsTableView reloadData];
    [self.villainsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    
    [self updateDetailViews];
}

- (IBAction)takeName:(id)sender {
    [self.villain setObject:[sender stringValue] forKey:kName];
    NSLog(@"current villain properties: %@", self.villain);
    [self.villainsTableView reloadData];
    [self updateDetailViews];
}

- (IBAction)takeLastKnownLocation:(id)sender {
    [self.villain setObject:[sender stringValue] forKey:kLastKnownLocation];
    NSLog(@"current villain properties: %@", self.villain);
}

- (IBAction)takeLastSeenDate:(id)sender {
    [self.villain setObject:[sender dateValue] forKey:kLastSeenDate];
    NSLog(@"current villain properties: %@", self.villain);
    [self.villainsTableView reloadData];
    [self updateDetailViews];
}

- (IBAction)takeSwornEnemy:(id)sender {
    [self.villain setObject:[sender stringValue] forKey:kSwornEnemy];
    NSLog(@"current villain properties: %@", self.villain);
}

- (IBAction)takePrimaryMotivation:(id)sender {
    [self.villain setObject:[[sender selectedCell] title] forKey:kPrimaryMotivation];
    NSLog(@"current villain properties: %@", self.villain);
}

- (IBAction)takePowerSource:(id)sender {
    [self.villain setObject:[sender title] forKey:kPowerSource];
    NSLog(@"current villain properties: %@", self.villain);
}

- (IBAction)takeEvilness:(id)sender {
    [self.villain setObject:[NSNumber numberWithInteger:[sender integerValue]] forKey:kEvilness];
    NSLog(@"current villain properties: %@", self.villain);
}

- (IBAction)takeMugshot:(id)sender {
    [self.villain setObject:[sender image] forKey:kMugshot];
    NSLog(@"current villain properties: %@", self.villain);
    [self.villainsTableView reloadData];
    [self updateDetailViews];
}

- (IBAction)takePowers:(id)sender {
    NSMutableArray *powers = [NSMutableArray array];
    for (NSCell *cell in [sender cells]) {
        if ([cell state]==NSOnState) {
            [powers addObject:[cell title]];
        }
    }
    [self.villain setObject:powers forKey:kPowers];
    NSLog(@"current villain properties: %@", self.villain);
}


- (IBAction)newVillain:(id)sender {
    [_window endEditingFor:nil];
    [self.villains addObject:[NSMutableDictionary
                         dictionaryWithObjectsAndKeys:
                         @"", kName,
                         @"", kLastKnownLocation,
                         [NSDate date], kLastSeenDate,
                         @"", kSwornEnemy,
                         @"Greed", kPrimaryMotivation,
                         [NSArray array], kPowers,
                         @"", kPowerSource,
                         [NSNumber numberWithInt:0], kEvilness,
                         [NSImage imageNamed:@"NSUser"], kMugshot,
                         @"" , kNotes,
                         nil]];
    
    [self.villainsTableView reloadData];
    
    [self.villainsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[self.villains count]-1]
                   byExtendingSelection:NO];

}

- (IBAction)deleteVillain:(id)sender {
	//
	// Section 1:
	//
	[_window endEditingFor:nil];
	NSInteger selectedRow = [self.villainsTableView selectedRow];
	
	//
	// Section 2:
	//
	[self.villains removeObjectIdenticalTo:self.villain];
	[self.villainsTableView reloadData];
	
	//
	// Section 3:
	//
	if (selectedRow >= [self.villains count]) {
		selectedRow = [self.villains count]-1;
	}
	
	//
	// Section 4:
	//
	if (selectedRow > -1) {
		// deselect all rows to ensure that the tableview sees the
		// selection as “changed”, even though it might still have
	 	// the same row index.
		
		//
		// Section 5:
		//
		[self.villainsTableView deselectAll:nil];
		[self.villainsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:selectedRow] byExtendingSelection:NO];
		
		[self updateDetailViews];
	}
}

- (void)textDidChange:(NSNotification *)aNotification {
    [self.villain setObject:[[self.notesView string] copy] forKey:kNotes];
    NSLog(@"current villain properties: %@", self.villain);
}


- (void)updateDetailViews {
    [self.nameView setStringValue:[self.villain objectForKey:kName]];
    [self.lastKnownLocationView setStringValue:
     [self.villain objectForKey:kLastKnownLocation]];
    [self.lastSeenDateView setDateValue:[self.villain objectForKey:kLastSeenDate]];
    [self.evilnessView setIntegerValue:[[self.villain objectForKey:kEvilness] integerValue]];
    [self.powerSourceView setTitle:[self.villain objectForKey:kPowerSource]];
    [self.mugshotView setImage:[self.villain objectForKey:kMugshot]];
    [self.notesView setString:[self.villain objectForKey:kNotes]];
    if ([self.swornEnemyView indexOfItemWithObjectValue:
         [self.villain objectForKey:kSwornEnemy]]==NSNotFound) {
        [self.swornEnemyView addItemWithObjectValue:
         [self.villain objectForKey:kSwornEnemy]];
    }
    [self.swornEnemyView selectItemWithObjectValue:[self.villain objectForKey:kSwornEnemy]];
    [self.primaryMotivationView selectCellWithTag:[[[self class] motivations] indexOfObject:[self.villain objectForKey:kPrimaryMotivation]]];
    
    [self.powersView deselectAllCells];
    for (NSString *power in [[self class] powers]) {
        if ([[self.villain objectForKey:kPowers] containsObject:power]) {
            [[self.powersView cellWithTag:[[[self class] powers] indexOfObject:power]] setState:NSOnState];
        }
    }
}
+ (NSArray *)motivations {
    static NSArray *motivations = nil;
    if (!motivations) {
        motivations = [[NSArray alloc] initWithObjects:@"Greed", @"Revenge", @"Bloodlust", @"Nihilism", @"Insanity", nil];
    }
    return motivations;
}
+ (NSArray *)powers {
    static NSArray *powers = nil;
    if (!powers) {
        powers = [[NSArray alloc] initWithObjects:@"Evil Genius", @"Mind Reader", @"Nigh-invulnerable", @"Weather Control", nil];
    }
    return powers;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [self.villains count];
}

- (NSView *)tableView:(NSTableView *)aTableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    NSMutableDictionary *thisVillain = [self.villains objectAtIndex:row];
    NSString *thisColName = [tableColumn identifier];
    
    NSView *result = nil;
    
    // Depending on which column we're using, we need to do different things.
    // Passing [tableColumn identifier] to makeViewWithIdentifier ensures that we get the view that's already been configured for the column in IB, and AppKit manages this for us.
    if ([thisColName isEqualToString:kName]) {
        NSTableCellView *thisCell = [aTableView makeViewWithIdentifier:thisColName owner:self];
        thisCell.textField.stringValue = [thisVillain objectForKey:kName];
        result = thisCell;
    } else if ([thisColName isEqualToString:kLastSeenDate]) {
        NSTableCellView *thisCell = [aTableView makeViewWithIdentifier:thisColName owner:self];
        thisCell.textField.stringValue = [thisVillain objectForKey:kLastSeenDate];
        result = thisCell;
    } else if ([thisColName isEqualToString:kMugshot]) {
        NSImageView *thisCell = [aTableView makeViewWithIdentifier:thisColName owner:self];
        [thisCell setImage:[thisVillain objectForKey:kMugshot]];
        result = thisCell;
    }

    
    // return the result.
    return result;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    if ([self.villainsTableView selectedRow] > -1) {
        self.villain = [self.villains
                        objectAtIndex:[self.villainsTableView selectedRow]];
        [self updateDetailViews];
        NSLog(@"current villain properties: %@", self.villain);
    }
}


@end