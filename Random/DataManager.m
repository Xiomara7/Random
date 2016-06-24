//
//  DataManager.m
//  Random
//
//  Created by Xiomara on 6/24/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _likedImages = [[NSMutableArray alloc] init]; 
    }
    return self;
}

#pragma mark - Singleton Methods

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

@end
