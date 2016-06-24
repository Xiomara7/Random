//
//  CollectionCell.h
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *randomImageView;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *likesButton;

@end
