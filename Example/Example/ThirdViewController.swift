import UIKit


class ThirdViewController: UIViewController {

  // MARK: Public

  override var transitioningDelegate: UIViewControllerTransitioningDelegate? {
    didSet {
      self.strongTransitioningDelegate = transitioningDelegate
    }
  }

  private var strongTransitioningDelegate: UIViewControllerTransitioningDelegate?

  @IBAction func dismissViewController() {
    dismissViewControllerAnimated(true, completion: nil)
  }

}
