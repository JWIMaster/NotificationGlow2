#import <Foundation/Foundation.h>
#import "WXMRootListController.h"
#import <spawn.h>
#import <rootless.h>

@implementation WXMRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)respring {
	pid_t pid;
	const char* args[] = {"killall", "SpringBoard", NULL};
	posix_spawn(&pid, ROOT_PATH("/usr/bin/killall"), NULL, NULL, (char* const*)args, NULL);
}

@end
