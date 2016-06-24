//
//  DataManager.h
//  Random
//
//  Created by Xiomara on 6/24/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataManager : NSObject 

@property (nonatomic, strong) NSMutableArray<UIImage *> *likedImages;

+ (instancetype)sharedManager;

@end
