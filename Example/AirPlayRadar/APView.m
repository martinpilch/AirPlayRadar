//
// Created by martinpilch on 1/7/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "APView.h"
#import "AirPlayRadarView.h"

@implementation APView {

}

- (id)init {

  self = [super init];
  if ( self ) {

    AirPlayRadarView *radarView = [[AirPlayRadarView alloc] init];
    radarView.frame = CGRectMake(-200, -200, 10, 10);

    [self addSubview:radarView];
  }
  return self;
}

@end