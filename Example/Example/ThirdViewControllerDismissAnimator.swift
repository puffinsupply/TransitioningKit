import UIKit


class ThirdViewControllerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: Public

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.2
  }

  func animateTransition(context: UIViewControllerContextTransitioning) {
    let toNavigationController = context.viewControllerForKey(UITransitionContextToViewControllerKey) as! UINavigationController

    let fromView = context.viewForKey(UITransitionContextFromViewKey)!
    let toView   = toNavigationController.topViewController!.view

    let fromViewButton = fromView.subviews.first as! UIButton
    let toViewButton   = toView.subviews.first as! UIButton

    UIView.animateWithDuration(
      0.5,
      animations: {
        fromViewButton.transform  = CGAffineTransformMakeTranslation(0, fromView.frame.height)
        fromView.backgroundColor  = UIColor.clearColor()
      },
      completion: { _ in
        context.completeTransition(!context.transitionWasCancelled())

        UIView.animateWithDuration(0.5,
          delay:                   0,
          usingSpringWithDamping:  0.5,
          initialSpringVelocity:   0,
          options:                 [],
          animations:              { toViewButton.transform = CGAffineTransformIdentity },
          completion:              nil
        )
      }
    )
  }
  
}
