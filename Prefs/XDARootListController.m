#import <Foundation/Foundation.h>
#import "XDARootListController.h"
#import <notify.h>

@implementation XDARootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
