//
//  BookTableViewCell.m
//  iOSProject
//
//  Created by 360doc on 2018/4/8.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "BookTableViewCell.h"

@implementation BookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *bookCoverImage = [[UIImageView alloc] init];
        bookCoverImage.backgroundColor = DXWColorGray;
        [self.contentView addSubview:bookCoverImage];
        [bookCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12.5);
            make.bottom.equalTo(@(-12.5));
            make.left.equalTo(@15);
            make.width.mas_equalTo(50);
        }];
        
        UILabel *bookNameLabel = [[UILabel alloc] init];
        bookNameLabel.font = DXWFont(16);
        bookNameLabel.textColor = DXWColorRGB(35, 35, 35);
        bookNameLabel.text = @"书名";
        [self.contentView addSubview:bookNameLabel];
        [bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bookCoverImage.mas_right).offset(10);
            make.right.equalTo(@(-15));
            make.top.equalTo(bookCoverImage).offset(-1);
            make.height.mas_equalTo(18);
        }];
        
        UILabel *bookAuthorLabel = [[UILabel alloc] init];
        bookAuthorLabel.font = DXWFont(13);
        bookAuthorLabel.textColor = DXWColorRGB(128, 128, 128);
        bookAuthorLabel.text = @"作者";
        [self.contentView addSubview:bookAuthorLabel];
        [bookAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bookCoverImage.mas_right).offset(10);
            make.right.equalTo(@(-15));
            make.centerY.equalTo(bookCoverImage).offset(1.5);
            make.height.mas_equalTo(15);
        }];
        
        UILabel *bookNewChapterLabel = [[UILabel alloc] init];
        bookNewChapterLabel.font = DXWFont(13);
        bookNewChapterLabel.textColor = DXWColorRGB(128, 128, 128);
        bookNewChapterLabel.text = @"最新章节";
        [self.contentView addSubview:bookNewChapterLabel];
        [bookNewChapterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bookCoverImage.mas_right).offset(10);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(bookCoverImage).offset(1);
            make.height.mas_equalTo(15);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = DXWColorRGB(230, 230, 230);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.left.equalTo(@15);
            make.right.equalTo(@0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

@end
