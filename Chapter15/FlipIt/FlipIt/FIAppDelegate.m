//
//  FIAppDelegate.m
//  FlipIt
//
//  Created by Peter Clark on 2/27/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "FIAppDelegate.h"
#define ANIM_DURATION 1.0

@implementation FIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.items = [self.tabView tabViewItems];
    self.currentTabIndex = [self.items count]-1;
    [self prepareRightSide];
    [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
    [self transitionInFromRight];
    self.currentTabIndex = 0;
    self.middleView = self.rightView;
}

- (void)prepareRightSide {
    NSInteger nextTabIndex = self.currentTabIndex + 1;
    if (nextTabIndex >= [self.items count])
        nextTabIndex = 0;
    
    self.rightView = [[self.items objectAtIndex:nextTabIndex] view];
    
    NSRect viewFrame = [self.box bounds];
    viewFrame.origin.x += viewFrame.size.width;
    
    [self.rightView setFrame:viewFrame];
    [self.rightView setAlphaValue:0.0];
    [self.box addSubview:self.rightView];
}

- (void)transitionInFromRight {
    [[self.rightView animator] setFrame:[self.box bounds]];
    [[self.rightView animator] setAlphaValue:1.0];
}

- (void)transitionOutToLeft {
    NSRect newFrame = [self.middleView frame];
    newFrame.origin.x -= newFrame.size.width;
    [[self.middleView animator] setFrame:newFrame];
    [[self.middleView animator] setAlphaValue:0.0];
}

- (IBAction)next:(id)sender {
    [self prepareRightSide];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
    [self transitionInFromRight];
    [self transitionOutToLeft];
    [NSAnimationContext endGrouping];
    
    self.currentTabIndex++;
    if (self.currentTabIndex >= [self.items count])
        self.currentTabIndex = 0;
    self.leftView = self.middleView;
    self.middleView = self.rightView;
}


- (void)prepareLeftSide {
    NSInteger previousTabIndex = self.currentTabIndex-1;
    if (previousTabIndex < 0)
        previousTabIndex = [self.items count]-1;
    
    self.leftView = [[self.items objectAtIndex:previousTabIndex] view];
    
    NSRect viewFrame = [self.box bounds];
    viewFrame.origin.x -= viewFrame.size.width;
    
    [self.leftView setFrame:viewFrame];
    [self.leftView setAlphaValue:0.0];
    [self.box addSubview:self.leftView];
}

- (void)transitionInFromLeft {
    [[self.leftView animator] setFrame:[self.box bounds]];
    [[self.leftView animator] setAlphaValue:1.0];
}

- (void)transitionOutToRight {
    NSRect newFrame = [self.middleView frame];
    newFrame.origin.x += [self.box bounds].size.width;
    [[self.middleView animator] setFrame:newFrame];
    [[self.middleView animator] setAlphaValue:0.0];
}

- (IBAction)previous:(id)sender {
    [self prepareLeftSide];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:ANIM_DURATION];
    [self transitionInFromLeft];
    [self transitionOutToRight];
    [NSAnimationContext endGrouping];
    
    self.currentTabIndex--;
    if (self.currentTabIndex < 0)
        self.currentTabIndex = [self.items count]-1;
    self.rightView = self.middleView;
    self.middleView = self.leftView;
}


@end
