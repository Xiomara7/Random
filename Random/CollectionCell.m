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
        
        self.randomImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.randomImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.randomImageView];
        
        self.shareButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.shareButton setImage:[UIImage imageNamed:@"share_icon"]
                          forState:UIControlStateNormal];
        
        [self addSubview:self.shareButton];
        
        self.likesButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.likesButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.likesButton setImage:[UIImage imageNamed:@"heart_icon"]
                          forState:UIControlStateNormal];
        
        [self.likesButton setImage:[UIImage imageNamed:@"heart_icon_filled"]
                          forState:UIControlStateSelected];
        [self addSubview:self.likesButton];
        
        self.categoryTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.categoryTitle setHidden:YES];
        [self.categoryTitle setTextColor:[UIColor lightGrayColor]];
        [self.categoryTitle setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:20.0]];
        
        [self addSubview:self.categoryTitle];
        
        self.separator = [[UIView alloc] initWithFrame:CGRectZero];
        self.separator.translatesAutoresizingMaskIntoConstraints = NO;
        self.separator.backgroundColor = [UIColor lightGrayColor];
        
        [self.separator autoSetDimension:ALDimensionWidth toSize:1.0];
        [self.separator autoSetDimension:ALDimensionHeight toSize:34.0];
        
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
    
    [self.categoryTitle autoCenterInSuperview];
    
    [super updateConstraints];
}

-(void)prepareForReuse {
    self.selected = FALSE;
}

@end
