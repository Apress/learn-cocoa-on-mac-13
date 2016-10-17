//
//  CMDocument.h
//  ColorMix
//
//  Created by Jack on 1/9/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CMColorBlendView;

@interface CMDocument : NSPersistentDocument

@property (weak) IBOutlet CMColorBlendView *multiplyBlendView;
@property (weak) IBOutlet CMColorBlendView *screenBlendView;
@property (weak) IBOutlet CMColorBlendView *overlayBlendView;
@property (weak) IBOutlet CMColorBlendView *darkenBlendView;
@property (weak) IBOutlet CMColorBlendView *lightenBlendView;
@property (weak) IBOutlet CMColorBlendView *colorDodgeBlendView;
@property (weak) IBOutlet CMColorBlendView *colorBurnBlendView;
@property (weak) IBOutlet CMColorBlendView *softLightBlendView;
@property (weak) IBOutlet CMColorBlendView *hardLightBlendView;
@property (weak) IBOutlet CMColorBlendView *differenceBlendView;
@property (weak) IBOutlet CMColorBlendView *exclusionBlendView;
@property (weak) IBOutlet CMColorBlendView *hueBlendView;
@property (weak) IBOutlet CMColorBlendView *saturationBlendView;
@property (weak) IBOutlet CMColorBlendView *colorBlendView;
@property (weak) IBOutlet CMColorBlendView *luminosityBlendView;

@end
