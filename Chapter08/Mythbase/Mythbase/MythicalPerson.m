//
//  MythicalPerson.m
//  MythBase
//
//  Created by Peter Clark on 10/6/12.
//  Copyright (c) 2012 myself. All rights reserved.
//

#import "MythicalPerson.h"


@implementation MythicalPerson

@dynamic depiction;
@dynamic details;
@dynamic divinity;
@dynamic goodness;
@dynamic name;
@dynamic power;

- (BOOL)validateName:(id *)ioValue error:(NSError **)outError
{
    if (*ioValue == nil) {
        return YES;
    }
    if ([*ioValue isEqualToString:@"Bob"]) {
        if (outError != NULL) {
            NSString *errorStr = NSLocalizedString(
                                                   @"You're not allowed to name a mythical person ‘Bob’.  "
                                                   " ‘Bob’ is a real person, just like you and me.",
                                                   @"validation: invalid name error");
            NSDictionary *userInfoDict = [NSDictionary
                                          dictionaryWithObject:errorStr
                                          forKey:NSLocalizedDescriptionKey];
            NSError *error = [[NSError alloc]
                              initWithDomain:@"MythicalPersonErrorDomain"
                              code:13013 userInfo:userInfoDict];
            *outError = error;
        }
        return NO;
    }
    return YES;
}

- (NSError *)errorFromOriginalError:(NSError *)originalError
                              error:(NSError *)secondError
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSMutableArray *errors = [NSMutableArray
                              arrayWithObject:secondError];
    
    if ([originalError code] == NSValidationMultipleErrorsError) {
        [userInfo addEntriesFromDictionary:[originalError userInfo]];
        [errors addObjectsFromArray:[userInfo
                                     objectForKey:NSDetailedErrorsKey]];
    }
    else {
        [errors addObject:originalError];
    }
    [userInfo setObject:errors forKey:NSDetailedErrorsKey];
    return [NSError errorWithDomain:NSCocoaErrorDomain
                               code:NSValidationMultipleErrorsError
                           userInfo:userInfo];
}


- (BOOL)validateForInsert:(NSError **)error
{
    BOOL propertiesValid = [super validateForInsert:error];
    BOOL consistencyValid = [self validateConsistency:error];
    return (propertiesValid && consistencyValid);
}

- (BOOL)validateForUpdate:(NSError **)error
{
    BOOL propertiesValid = [super validateForUpdate:error];
    BOOL consistencyValid = [self validateConsistency:error];
    return (propertiesValid && consistencyValid);
}

- (BOOL)validateConsistency:(NSError **)error
{
    int divinity = [[self valueForKey:@"divinity"] intValue];
    int power = [[self valueForKey:@"power"] intValue];
    if (divinity < 100 && power > 50) {
        if (error != NULL) {
            NSString *errorStr = NSLocalizedString(
                                                   @"Power cannot exceed 50 unless divinity is 100",
                                                   @"validation: divinity / power error");
            NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorStr
                                                                     forKey:NSLocalizedDescriptionKey];
            NSError *divinityPowerError = [[NSError alloc]
                                           initWithDomain:@"MythicalPersonErrorDomain" code:182
                                           userInfo:userInfoDict];
            if (*error == nil) {
                // there was no previous error, return the new error
                *error = divinityPowerError;
            }
            else {
                // combine previous error with the new one
                *error = [self errorFromOriginalError:*error error:divinityPowerError];
            }
        }
        return NO;
    }
    return YES;
}


- (int)awesomeness
{
    int awesomeness = [[self valueForKey:@"divinity"] intValue] * 10 +
        [[self valueForKey:@"power"] intValue] * 5 +
        [[self valueForKey:@"goodness"] intValue];
    return awesomeness;
}

+ (NSSet *)keyPathsForValuesAffectingAwesomeness {
    return [NSSet setWithObjects:@"divinity", @"power", @"goodness",
            nil];
}

@end
