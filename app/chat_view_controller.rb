class ChatViewController < UIViewController

  def viewDidLoad
    view.backgroundColor = UIColor.blackColor

    message_box = UITextField.alloc.init
    message_box.frame = [[5,30],[310,25]]
    message_box.borderStyle = UITextBorderStyleRoundedRect
    message_box.placeholder = "enter message here"
    message_box.backgroundColor = UIColor.whiteColor
    message_box.delegate = self

    view.addSubview message_box

    @tableView = UITableView.alloc.init
    @tableView.frame = [[5,65],[310,360]]
    @tableView.dataSource = @tableView.delegate = self

    view.addSubview @tableView

    @logout = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @logout.frame = [[5,430],[310,40]]
    @logout.setTitle("Log Out", forState: UIControlStateNormal)
    @logout.addTarget(self, action:"logout", forControlEvents: UIControlEventTouchUpInside)

    view.addSubview @logout

    @messages = []
  end

  def viewDidAppear(animated)
    display_login unless PFUser.currentUser
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
    record_message textField.text
    textField.text = ""
    @tableView.reloadData
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @messages.size || 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("cell") || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:"cell")
    cell.textLabel.text = @messages[indexPath.row]
    cell
  end

  def logInViewController(logIn, didLogInUser:user)
    @login.dismissModalViewControllerAnimated(true)
  end

  def display_login
    @login = PFLogInViewController.alloc.init
    @login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton
    @login.delegate = self
    @login.signUpController.delegate = self
    self.presentModalViewController(@login, animated:true)
  end

  def logout
    PFUser.logOut
    display_login
  end

  def record_message(message)
    PFPush.sendPushMessageToChannel("", withMessage:message)
    display_message(message)
  end

  def display_message(message)
    @messages.unshift message
    @tableView.reloadData
  end
end
