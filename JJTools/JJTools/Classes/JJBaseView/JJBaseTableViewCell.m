//
//  JJBaseTableViewCell.m
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//
#import "Masonry.h"
#import "JJMacroDefine.h"
#import "JJFontDefine.h"
#import "JJColorDefine.h"
#import "UIColor+JJTools.h"
#import "UILabel+MasonryLayout.h"
#import "UIButton+MasonryLayout.h"
#import "UIImageView+MasonryLayout.h"
#import "UIView+MasonryLayout.h"
#import "UITextField+MasonryLayout.h"
#import "UIImage+JJTools.h"
#import "JJBaseTableViewCell.h"


@interface JJBaseTableViewCell ()

@property (nonatomic, strong) UIView                               *topline;
@property (nonatomic, strong) UIView                               *underline;

@end


@implementation JJBaseTableViewCell

+ (JJBaseTableViewCell *)getCellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"JJBaseTableViewCell";
    JJBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if ( !cell ) {
        cell = [[JJBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setupSubViews];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)setupSubViews
{
    self.topline =[[UIView alloc]init];
    self.topline.hidden = YES;
    
    self.topline.backgroundColor =Color_TableViewEmpty_SubTitleColor;
    [self.contentView addSubview:self.topline];
    
    [self.topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    self.underline =[[UIView alloc]init];
    self.underline.hidden =YES;
    
    self.underline.backgroundColor =Color_TableViewEmpty_SubTitleColor;
    [self.contentView addSubview:self.underline];
    
    [self.underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _showCustomSeparatorLine =YES;
}

#pragma mark -Getter
- (UILabel *)customTextLabel
{
    if (!_customTextLabel)
    {
        _customTextLabel = [[UILabel alloc] init];
        
        _customTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if (!_customTextLabel.superview)
    {
        [self.contentView addSubview:_customTextLabel];
    }
    
    return _customTextLabel;
}

- (UILabel *)customDetailTextLabel
{
    if (!_customDetailTextLabel)
    {
        _customDetailTextLabel = [[UILabel alloc] init];
        
        _customDetailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    
    if (!_customDetailTextLabel.superview)
    {
        [self.contentView addSubview:_customDetailTextLabel];
    }
    
    return _customDetailTextLabel;
}

#pragma mark -Setter

-(void)setCustomAccessoryType:(JJTableViewCellCustomAccessoryType)customAccessoryType
{
    if (_customAccessoryType !=customAccessoryType) {
        _customAccessoryType =customAccessoryType;
    }
}

- (void)setCustomAccessoryView:(UIView *)customAccessoryView
{
    if (_customAccessoryView != customAccessoryView)
    {
        _customAccessoryView = customAccessoryView;
        
        [self handleCustomAccessoryView];
    }
}

#pragma mark -override
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    if (self.customAccessoryView)
    {
        [self.customAccessoryView removeFromSuperview];
        self.customAccessoryView = nil;
    }
    
    self.customAccessoryView.hidden = YES;
    
    self.topline.hidden = YES;
    self.underline.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsUpdateConstraints];
    
    if (_showCustomSeparatorLine)
    {
        [self.topline setHidden:NO];
        [self.underline setHidden:NO];
        
        UIView * superView = self.superview;
        UITableView * tableView = nil;
        
        if ([superView isKindOfClass:[UITableView class]])
        {
            tableView = (UITableView *)superView;
        }
        else
        {
            // Test on iOS 10.3.1, the super view of cell is UITableViewWrapperView
            // The super view of UITableViewWrapperView is UITableView
            Class class = NSClassFromString(@"UITableViewWrapperView");
            
            if ([superView isKindOfClass:class])
            {
                UIView * newSuperView = superView.superview;
                
                if ([newSuperView isKindOfClass:[UITableView class]])
                {
                    tableView = (UITableView *)newSuperView;
                }
            }
        }
        
        if (tableView && self.indexPath)
        {
            if ([tableView isKindOfClass:[UITableView class]])
            {
                NSInteger numberOfItemsInSection = [tableView numberOfRowsInSection:self.indexPath.section];
                
                // Check topline showing
                if (0 == _indexPath.row)
                {
                    self.topline.hidden = NO;
                }
                else
                {
                    self.topline.hidden = YES;
                }
                
                self.underline.hidden = NO;
                
                if (self.separatorLineLayoutBlock)
                {
                    self.separatorLineLayoutBlock(self.topline.hidden? nil : self.topline, self.underline, numberOfItemsInSection - 1 == _indexPath.row);
                }
                
            }
        }
    }
    else
    {
        [self.topline setHidden:YES];
        [self.underline setHidden:YES];
    }
}

- (void)updateConstraints
{
    if (self.customAccessoryView)
    {
        self.customAccessoryView.hidden = NO;
        CGRect accessoryViewFrame = CGRectZero;
        
        if (self.customAccessoryType == TableViewCellCustomAccessoryTypeDisclosureIndicator)
        {
            accessoryViewFrame = CGRectMake(0.0f, 0.0f, 16.0f, 26.0f);
        }
        else
        {
            if ([self.customAccessoryView isKindOfClass:[UISwitch class]])
            {
                accessoryViewFrame = CGRectMake(0.0f, 0.0f, 52.0f, 26.0f);
            }
            else
            {
                accessoryViewFrame = self.customAccessoryView.frame;
            }
        }
        
        if (CGRectEqualToRect(accessoryViewFrame, CGRectZero))
        {
            accessoryViewFrame = CGRectMake(0.0f, 0.0f, 24.0f, 24.0f);
        }
        
        CGFloat maxX = CGRectGetMaxX(self.contentView.frame);
        
        CGFloat mid = accessoryViewFrame.size.width / 2;
        
        CGFloat centerX = maxX - 16.0f - mid;
        
        [self.customAccessoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-16.0f);
            make.size.mas_equalTo(accessoryViewFrame.size);
            
        }];
    }
    else
    {
        self.customAccessoryView.hidden = YES;
    }
    
    if (self.customDetailTextLabel.text.length > 0)
    {
        self.customDetailTextLabel.hidden = NO;
        
        CGFloat defaultTextLabelHeight = 18.0f;
        
        if (defaultTextLabelHeight > CGRectGetHeight(self.contentView.frame))
        {
            defaultTextLabelHeight = CGRectGetHeight(self.contentView.frame);
        }
        
        CGRect textLabelRect = CGRectZero;
        
        CGSize textSize;
        
        textSize.width = CGFLOAT_MAX;
        textSize.height = defaultTextLabelHeight;
        
        NSDictionary *attributes = @{NSFontAttributeName: self.customDetailTextLabel.font};
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        textLabelRect = [self.customDetailTextLabel.text boundingRectWithSize:textSize
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:attributes
                                                                      context:nil];
        
        [self.customDetailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_lessThanOrEqualTo(200.0f).priorityHigh();
            make.size.mas_equalTo(CGSizeMake(textLabelRect.size.width, defaultTextLabelHeight)).priorityMedium();
            
            if (self.customAccessoryView)
            {
                make.trailing.equalTo(self.customAccessoryView.mas_leading).with.offset(-10.0f);
            }
            else
            {
                make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-16.0f);
            }
            
        }];
    }
    else
    {
        self.customDetailTextLabel.hidden = YES;
    }
    
    if (self.customTextLabel.text.length > 0)
    {
        self.customTextLabel.hidden = NO;
        
        CGFloat defaultTextLabelHeight = 25.0f;
        
        if (defaultTextLabelHeight > CGRectGetHeight(self.contentView.frame))
        {
            defaultTextLabelHeight = CGRectGetHeight(self.contentView.frame);
        }
        
        [self.customTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.leading.equalTo(self.contentView.mas_leading).with.offset(16.0f);
            
            if (!self.customDetailTextLabel.hidden)
            {
                make.trailing.equalTo(self.customDetailTextLabel.mas_leading).with.offset(-10.0f);
            }
            else if (self.customAccessoryView)
            {
                make.trailing.equalTo(self.customAccessoryView.mas_leading).with.offset(-10.0f);
            }
            else
            {
                make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-16.0f);
            }
            
            make.height.mas_equalTo(defaultTextLabelHeight);
            
        }];
    }
    else
    {
        self.customTextLabel.hidden = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Private Methods
- (void)handleCustomAccessoryView
{
    if (!self.customAccessoryView) {
        
      self.customAccessoryView= [self createCustomAccessoryViewWith:self.customAccessoryType];
    }
    
    if (self.customAccessoryView && !self.customAccessoryView.superview)
    {
        [self.contentView addSubview:self.customAccessoryView];
    }
    
    [self setNeedsLayout];
}

- (UIView *)createCustomAccessoryViewWith:(JJTableViewCellCustomAccessoryType)accessoryType
{
    UIView * customAccessoryView = nil;
    
    if (accessoryType == TableViewCellCustomAccessoryTypeDisclosureIndicator)
    {
        customAccessoryView = [self createIndicatorButton];
    }

    else
    {
        
    }
    
    return customAccessoryView;
}

- (UIButton *)createIndicatorButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 16.0f, 26.0f);
    
    UIImage * image = [UIImage imageNamed:@""];
    
    [button setImage:image
            forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)configJJBaseTableViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexPath:(NSIndexPath *)indexPath
{
    
    
    
}


#pragma mark - Button Actions
- (void)buttonAction:(id)sender
{
    if (sender)
    {
        if (self.disclosureIndicatorButtonDidPress)
        {
            self.disclosureIndicatorButtonDidPress(self);
        }
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
