class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Parse.setApplicationId("YJDucFytJ3AFDnxE36bEslbv9EdbRqOs0hYt7ClF", clientKey:"O8exR5NRDlu34mDjfOzr0yCUXKdM8T6ikPxmex04")
    application.registerForRemoteNotificationTypes(UIRemoteNotificationTypeBadge)
    setup_initial_view
    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
    PFPush.storeDeviceToken(deviceToken)
    PFPush.subscribeToChannelInBackground("chat")
  end

  def appication(application, didReceiveRemoteNotification:userInfo)
    @chat_window.display_message(userInfo)
  end

  def setup_initial_view
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @chat_window = ChatViewController.alloc.init
    @window.rootViewController = @chat_window
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
