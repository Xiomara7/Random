//
//  CollectionCell.m
//  Random
//
//  Created by Xiomara on 6/23/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

#import "CollectionCell.h"
#import <PureLayout/PureLayout.h>

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        _randomImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _randomImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_randomImageView];
        
        _shareButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _shareButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_shareButton setImage:[UIImage imageNamed:@"share_icon"]
                      forState:UIControlStateNormal];
        [self addSubview:_shareButton];
        
        _likesButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _likesButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_likesButton setImage:[UIImage imageNamed:@"heart_icon"]
                      forState:UIControlStateNormal];
        [self addSubview:_likesButton];
        
        _separator = [[UIView alloc] initWithFrame:CGRectZero];
        _separator.translatesAutoresizingMaskIntoConstraints = NO;
        _separator.backgroundColor = [UIColor lightGrayColor];
        
        [_separator autoSetDimension:ALDimensionWidth toSize:1.0];
        [_separator autoSetDimension:ALDimensionHeight toSize:34.0];
        
        [self addSubview:_separator];
        [self setNeedsUpdateConstraints];
    }

    return self;
}

- (void)updateConstraints {
    [self.randomImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.randomImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:54.0];
    
    [self.separator autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.separator autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0];
    
    [self.likesButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_separator withOffset:-34.0];
    [self.likesButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_separator];
    
    [self.shareButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_separator withOffset:34.0];
    [self.shareButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_separator];
    
    
    [super updateConstraints];
}

@end
