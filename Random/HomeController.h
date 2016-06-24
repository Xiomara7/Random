//
//  HomeController.h
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController< UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout,
                                              UISearchBarDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *randomImages;
@property (nonatomic, strong) NSMutableArray<UIImage *> *likedImages;

@property (nonatomic, strong) UIActivityViewController *shareView;
@property (nonatomic, strong) UISearchBar *searchBar; 

@end
