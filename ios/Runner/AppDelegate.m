#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import Firebase;


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

      // Use Firebase library to configure APIs
[FIRApp configure];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
