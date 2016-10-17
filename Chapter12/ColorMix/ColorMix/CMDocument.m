//
//  CMDocument.m
//  ColorMix
//
//  Created by Jack on 1/9/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import "CMDocument.h"
#import "CMColorBlendView.h"

@interface CMDocument ()

@property (weak) IBOutlet NSObjectController *objectController;

@end

@implementation CMDocument
{
    BOOL isNew;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (id)initWithType:(NSString *)typeName error:(NSError **)outError{
    if (self = [super initWithType:typeName error:outError]) {
        isNew = YES;
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"CMDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    if (isNew) {
        id newObj = [_objectController newObject];
        [newObj setValue:[NSColor redColor] forKey:@"color1"];
        [newObj setValue:[NSColor yellowColor] forKey:@"color2"];
        [_objectController addObject:newObj];
    }
    
    _multiplyBlendView.blendMode = kCGBlendModeMultiply;
    _screenBlendView.blendMode = kCGBlendModeScreen;
    _overlayBlendView.blendMode = kCGBlendModeOverlay;
    _darkenBlendView.blendMode = kCGBlendModeDarken;
    _lightenBlendView.blendMode = kCGBlendModeLighten;
    _colorDodgeBlendView.blendMode = kCGBlendModeColorDodge;
    _colorBurnBlendView.blendMode = kCGBlendModeColorBurn;
    _softLightBlendView.blendMode = kCGBlendModeSoftLight;
    _hardLightBlendView.blendMode = kCGBlendModeHardLight;
    _differenceBlendView.blendMode = kCGBlendModeDifference;
    _exclusionBlendView.blendMode = kCGBlendModeExclusion;
    _hueBlendView.blendMode = kCGBlendModeHue;
    _saturationBlendView.blendMode = kCGBlendModeSaturation;
    _colorBlendView.blendMode = kCGBlendModeColor;
    _luminosityBlendView.blendMode = kCGBlendModeLuminosity;
    
    NSArray *allBlendViews =
    @[_multiplyBlendView, _screenBlendView, _overlayBlendView,
    _darkenBlendView, _lightenBlendView, _colorDodgeBlendView,
    _colorBurnBlendView, _softLightBlendView, _hardLightBlendView,
    _differenceBlendView, _exclusionBlendView, _hueBlendView,
    _saturationBlendView, _colorBlendView, _luminosityBlendView];
    
    for (CMColorBlendView *cbv in allBlendViews) {
        [cbv bind:@"color1"
         toObject:_objectController
     withKeyPath:@"selection.color1"
          options:nil];
        
        [cbv bind:@"color2"
         toObject:_objectController
      withKeyPath:@"selection.color2"
          options:nil];
    }
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
