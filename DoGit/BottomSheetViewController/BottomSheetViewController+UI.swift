//
//  BottomSheetViewController+UI.swift
//  DoGit
//
//  Created by neuli on 2022/04/21.
//

import UIKit

extension BottomSheetViewController {
    
    func setUI() {
        view.addSubview(blurView)
        view.addSubview(bottomSheetView)
        view.addSubview(dragIndicatorView)
        
        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        bottomSheetView.addConstraints(contentViewController.view.constraints)
        contentViewController.didMove(toParent: self)
        bottomSheetView.clipsToBounds = true
        
        blurView.alpha = 0.0
        
        setLayout()
    }
    
    private func setLayout() {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])
        
        dragIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: dragIndicatorView.layer.cornerRadius * 2),
            dragIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dragIndicatorView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: -10)
        ])
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
        ])
    }
}
