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


public class PSNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

  public init(
    pushAnimator:          UIViewControllerAnimatedTransitioning? = nil,
    popAnimator:           UIViewControllerAnimatedTransitioning? = nil,
    interactionController: UIPercentDrivenInteractiveTransition? = nil
    ) {
      self.pushAnimator = pushAnimator
      self.popAnimator  = popAnimator

      self.interactionController = interactionController

      super.init()
  }

  // MARK: Public

  let interactionController: UIPercentDrivenInteractiveTransition?

  public func navigationController(
    navigationController:            UINavigationController,
    animationControllerForOperation: UINavigationControllerOperation,
    fromViewController:              UIViewController,
    toViewController:                UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      switch animationControllerForOperation {
      case .Push: return pushAnimator
      case .Pop:  return popAnimator
      default:    return nil
      }
  }

  public func navigationController(
    navigationController: UINavigationController,
    interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
      return interactionController
  }

  // MARK: Private

  private let pushAnimator: UIViewControllerAnimatedTransitioning?
  private let popAnimator:  UIViewControllerAnimatedTransitioning?
  
}
