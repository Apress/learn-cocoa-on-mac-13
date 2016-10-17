//
//  MLListWindowDelegate.m
//  MenuLab
//
//  Created by Peter Clark on 1/19/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import "MLListWindowDelegate.h"

@implementation MLListWindowDelegate
- (BOOL)validateUserInterfaceItem: (id <NSValidatedUserInterfaceItem>)anItem {
    
    // set the default response to YES, in case it's not the action we care about
    BOOL result = YES;
    
    SEL theAction = [anItem action];
    if (theAction == @selector(specialAction:) ) {
        if (self.selectedTag != 13013) {
            result = NO;
        }
    }
    return result;
}

- (void)specialAction:(id)sender {
    NSRunAlertPanel(@"Boy Howdy!",
                    @"That's some mighty special action you got there!",
                    nil, nil, nil);
}

@end
