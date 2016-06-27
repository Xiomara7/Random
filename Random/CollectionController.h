//
//  CollectionController.h
//  Random
//
//  Created by Xiomara on 6/24/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionController : UIViewController< UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *randomImages;
@property (nonatomic, strong) NSMutableArray<UIImage *> *likedImages;
@property (nonatomic, strong) UIActivityViewController *shareView;

@property (nonatomic, strong) NSString *currentCollection;
@property NSString *unspashURL;

-(instancetype)initWithCollection:(NSString *)collection;

@end
