/*
 Copyright (c) 2012 Martin Pilch ( http://martinpilch.com/ )

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

#import "AirPlayRadarView.h"

@interface AirPlayRadarView () {
  UIButton *_airPlayButton;
  BOOL _airPlayAvailable;
}

@end

@implementation AirPlayRadarView

#pragma mark -
#pragma mark Lifecycle

- (id)init {

  self = [super init];
  if ( self ) {

    //ad observer of appearance of the AirPlay button
    for (UIView *view in self.subviews) {
      if ([view isKindOfClass:[UIButton class]]) {
        _airPlayButton = (UIButton *)view;
        [_airPlayButton addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
      }
    }

  }
  return self;
}

- (void)dealloc {

  [_airPlayButton removeObserver:self forKeyPath:@"alpha"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

  if (![object isKindOfClass:[UIButton class]])
    return;

  BOOL isNowAvailable = [[change valueForKey:NSKeyValueChangeNewKey] floatValue] == 1;
  if ( isNowAvailable != _airPlayAvailable )
  {
    _airPlayAvailable = isNowAvailable;

    NSString *notification = _airPlayAvailable ? kAirPlayDeviceAvailableNotification : kAirPlayDeviceNotAvailableNotification;
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
  }
}

@end