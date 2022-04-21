//
//  BottomSheetViewController+Actions.swift
//  DoGit
//
//  Created by neuli on 2022/04/21.
//

import UIKit

extension BottomSheetViewController {
    @objc func blurViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        
        let velocity = panGestureRecognizer.velocity(in: view)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
            blurView.alpha = blurViewAlphaWithBottomSheetTopConstaint(value: bottomSheetViewTopConstraint.constant)
        case .ended:
            if velocity.y > 1500 {
                hideBottomSheetAndGoBack()
                return
            }
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight
            
            let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])
            
            if nearestValue == bottomSheetPanMinTopConstant {
                showBottomSheet(atState: .expanded)
            } else if nearestValue == defaultPadding {
                showBottomSheet(atState: .normal)
            } else {
                hideBottomSheetAndGoBack()
            }
        default:
            break
        }
    }
}
