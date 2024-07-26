#import <Foundation/Foundation.h>
#include <dlfcn.h>

static void nouse() {}
static void *_SMJobSubmit = (void *)nouse;
static BOOL enabled;
static NSString * debugserverPath;

#ifdef THEOS_PACKAGE_INSTALL_PREFIX
#define ROOTDIR THEOS_PACKAGE_INSTALL_PREFIX
#else
#define ROOTDIR
#endif

%hookf(Boolean, _SMJobSubmit, CFStringRef domain, CFDictionaryRef job, CFTypeID auth, CFErrorRef *outError) {
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:@(ROOTDIR "/var/mobile/Library/Preferences/com.zznq.xcodedebuganyprefs.plist")];
    NSNumber *enabledValue = (NSNumber *)[settings objectForKey:@"enabled"];
    enabled = (enabledValue)? [enabledValue boolValue] : YES;

    debugserverPath = [settings objectForKey:@"debugserverPath"];
	if(!debugserverPath.length) {
		debugserverPath = @(ROOTDIR "/usr/bin/debugserver");
	}

    if (enabled){
        NSMutableDictionary *njob = [(__bridge NSDictionary *)job mutableCopy];
        if (njob != nil && njob[@"ProgramArguments"] != nil) {
            NSMutableArray *programArgs = [njob[@"ProgramArguments"] mutableCopy];

            NSString *program = programArgs.firstObject;
            if ([program isEqualToString:@"/Developer/usr/bin/debugserver"] || [program isEqualToString:@"/usr/libexec/debugserver"]){
                programArgs[0] = debugserverPath;

                njob[@"UserName"] = @"root";
                njob[@"ProgramArguments"] = programArgs;
            }

            job = (__bridge_retained CFDictionaryRef)njob;
            NSLog(@"hook job: %@", job);
        }
    }
    
    return %orig;
}

%ctor {
    _SMJobSubmit = dlsym(RTLD_DEFAULT, "SMJobSubmit");
}
