//
//  HomeController.h
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController< UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *randomImages;
@property (nonatomic, strong) NSMutableArray<UIImage *> *likedImages;
@property (nonatomic, strong) UIActivityViewController *shareView; 

@end
