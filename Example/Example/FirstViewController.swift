import UIKit
import TransitioningKit


class FirstViewController: UIViewController {

  // MARK: Public

  override func viewDidLoad() {
    super.viewDidLoad()

    let pushAnimator                  = FirstViewToSecondViewPushAnimator()
    let interactionControllerDelegate = FirstViewInteractionControllerDelegate()
    let interactionController         = PSPanGestureInteractionController(viewController: self, delegate: interactionControllerDelegate)

    navigationControllerDelegate = PSNavigationControllerDelegate(
      pushAnimator:          pushAnimator,
      interactionController: interactionController
    )

    navigationController?.delegate = navigationControllerDelegate
  }

  @IBAction func buttonWasPressed(button: UIButton) {
    UIView.animateWithDuration(0.1, animations: { button.transform = CGAffineTransformMakeTranslation(-32, 0) })

    UIView.animateWithDuration(0.4,
      delay:                   0.1,
      usingSpringWithDamping:  0.4,
      initialSpringVelocity:   0,
      options:                 .CurveEaseOut,
      animations:              { button.transform = CGAffineTransformIdentity },
      completion:              nil
    )
  }

  // MARK: Private

  private var navigationControllerDelegate: PSNavigationControllerDelegate?

}

