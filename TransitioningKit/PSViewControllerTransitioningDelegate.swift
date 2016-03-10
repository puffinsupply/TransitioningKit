//  The MIT License (MIT)
//
//  Copyright (c) 2015 Adam Michela, The Puffin Supply Project
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import UIKit


public class PSViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

  public init(
    presentAnimator:        UIViewControllerAnimatedTransitioning? = nil,
    dismissAnimator:        UIViewControllerAnimatedTransitioning? = nil,
    interactionController:  UIPercentDrivenInteractiveTransition? = nil,
    presentationController: UIPresentationController? = nil
    ) {
      self.presentAnimator = presentAnimator
      self.dismissAnimator = dismissAnimator

      self.interactionController  = interactionController
      self.presentationController = presentationController

      super.init()
  }

  // MARK: Public

  var interactionController: UIPercentDrivenInteractiveTransition?

  public func animationControllerForPresentedController(
    presented:                       UIViewController,
    presentingController presenting: UIViewController,
    sourceController source:         UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return presentAnimator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dismissAnimator
  }

  public func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactionController
  }

  public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactionController
  }

  public func presentationControllerForPresentedViewController(
    presented:                           UIViewController,
    presentingViewController presenting: UIViewController,
    sourceViewController source:         UIViewController
    ) -> UIPresentationController? {
      return presentationController
  }

  // MARK: Private

  private let presentAnimator: UIViewControllerAnimatedTransitioning?
  private let dismissAnimator: UIViewControllerAnimatedTransitioning?

  private let presentationController: UIPresentationController?
  
}
