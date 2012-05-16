class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Parse.setApplicationId("YJDucFytJ3AFDnxE36bEslbv9EdbRqOs0hYt7ClF", clientKey:"O8exR5NRDlu34mDjfOzr0yCUXKdM8T6ikPxmex04")

    setup_initial_view
    true
  end

  def setup_initial_view
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = ChatViewController.alloc.init
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
