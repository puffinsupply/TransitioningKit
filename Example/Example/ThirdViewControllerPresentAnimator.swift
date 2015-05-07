import UIKit


class ThirdViewControllerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: Public

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.2
  }

  func animateTransition(context: UIViewControllerContextTransitioning) {
    let fromNavigationController = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController

    let fromView = fromNavigationController.topViewController.view
    let toView   = context.viewForKey(UITransitionContextToViewKey)!

    let fromViewButton = fromView.subviews.first as! UIButton
    let toViewButton   = toView.subviews.first as! UIButton

    context.containerView().addSubview(toView)

    toViewButton.transform = CGAffineTransformMakeScale(0, 0)
    toView.backgroundColor = UIColor.clearColor()

    UIView.animateWithDuration(
      0.5,
      animations: {
        fromViewButton.transform  = CGAffineTransformInvert(CGAffineTransformMakeTranslation(0, fromView.frame.height))

        toView.backgroundColor = UIColor(hue: 0.14, saturation: 0.7, brightness: 1, alpha: 1)
      },
      completion: { _ in
        context.completeTransition(!context.transitionWasCancelled())

        UIView.animateWithDuration(0.5,
          delay:                   0,
          usingSpringWithDamping:  0.5,
          initialSpringVelocity:   0,
          options:                 nil,
          animations:              { toViewButton.transform = CGAffineTransformIdentity },
          completion:              nil
        )
      }
    )
  }
  
}
