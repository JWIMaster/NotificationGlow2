#import <Foundation/Foundation.h>
#import "WXMRootListController.h"

@implementation WXMRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
