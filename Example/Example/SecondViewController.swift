import UIKit
import TransitioningKit


class SecondViewController: UIViewController {

  // MARK: Public

  @IBAction func presentThirdViewController() {
    let thirdViewController = storyboard!.instantiateViewControllerWithIdentifier("ThirdViewController") as UIViewController

    let presentAnimator = ThirdViewControllerPresentAnimator()
    let dismissAnimator = ThirdViewControllerDismissAnimator()

    thirdViewController.modalPresentationStyle = .Custom

    thirdViewController.transitioningDelegate = PSViewControllerTransitioningDelegate(
      presentAnimator: presentAnimator,
      dismissAnimator: dismissAnimator
    )

    presentViewController(thirdViewController, animated: true, completion: nil)
  }
  
}
