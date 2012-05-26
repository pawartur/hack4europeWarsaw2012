//
//  AWDefaultCell.m
//  Europea
//
//  Created by Artur Wdowiarski on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWTableViewCell.h"

@implementation AWTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
