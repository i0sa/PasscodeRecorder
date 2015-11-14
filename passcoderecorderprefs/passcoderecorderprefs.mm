#import <Preferences/Preferences.h>

#define PhoneCallerPreferencePath @"/var/mobile/Library/Preferences/com.i0sa.passcoderecorderprefs.plist"


@interface passcoderecorderprefsListController: PSListController {
}
@end

@implementation passcoderecorderprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"passcoderecorderprefs" target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *PhoneCallerSettings = [NSDictionary dictionaryWithContentsOfFile:PhoneCallerPreferencePath];
	if (!PhoneCallerSettings[specifier.properties[@"key"]]) {
		return specifier.properties[@"default"];
	}
	return PhoneCallerSettings[specifier.properties[@"key"]];
}
 
-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:PhoneCallerPreferencePath]];
	[defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:PhoneCallerPreferencePath atomically:YES];
	//NSDictionary *PhoneCallerSettings = [NSDictionary dictionaryWithContentsOfFile:PhoneCallerPreferencePath];
		//NSLog(@"PreferenceOrganizer2: [DEBUG] POSettings %@",PhoneCallerSettings);
	CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
	if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}


@end

// vim:ft=objc
