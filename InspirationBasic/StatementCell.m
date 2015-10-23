//
//  StatementCell.m
//  InspirationBasic
//
//  Created by Timothy Swan on 8/8/14.
//  Copyright (c) 2014 ___InspirationTeam___. All rights reserved.
//

#import "StatementCell.h"

@implementation StatementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.reduceBy = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0,0,150,90);
    self.imageView.bounds = CGRectMake(0, 0, 150, 90);
    self.textLabel.frame = CGRectMake(self.reduceBy, 0, 200, 40);   //change this to your needed
    self.detailTextLabel.frame = CGRectMake(250, 40, 200, 40);
}

- (void) reduceSize:(int)i {
    self.reduceBy = i;
    //CGRect frame = self.textLabel.frame;
    //self.textLabel.frame = CGRectMake(frame.origin.x - i, frame.origin.y, frame.size.width, frame.size.height);
    //self.textLabel.frame = CGRectMake(250, 0, 200, 40);
}

@end
