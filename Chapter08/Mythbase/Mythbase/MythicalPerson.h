//
//  MythicalPerson.h
//  MythBase
//
//  Created by Peter Clark on 10/6/12.
//  Copyright (c) 2012 myself. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MythicalPerson : NSManagedObject

@property (nonatomic, retain) id depiction;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * divinity;
@property (nonatomic, retain) NSNumber * goodness;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * power;

@end
