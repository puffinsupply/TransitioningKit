import UIKit
import TransitioningKit


class FirstViewInteractionControllerDelegate: PSPanGestureInteractionControllerDelegate {

  // MARK: Public

  @objc func handlePanGestureBeganLeft(gestureRecognizer gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition) {
    let secondViewController = viewController.storyboard!.instantiateViewControllerWithIdentifier("SecondViewController") as UIViewController

    viewController.navigationController?.pushViewController(secondViewController, animated: true)
  }

  @objc func handlePanGestureEndedLeft(gestureRecognizer gestureRecognizer: UIPanGestureRecognizer, viewController: UIViewController, interactionController: UIPercentDrivenInteractiveTransition) {
    let velocity = gestureRecognizer.velocityInView(viewController.view)

    (velocity.x < -250) ? interactionController.finishInteractiveTransition() : interactionController.cancelInteractiveTransition()
  }

}
