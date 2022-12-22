//
//  BottomSheetViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/19.
//

import UIKit
import RealmSwift

final class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        return view
    }()
    
    let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        return view
    }()
    
    var bottomSheetPanMinTopConstant: CGFloat = 30.0
    var defaultHeight: CGFloat = 600
    var bottomSheetViewTopConstraint: NSLayoutConstraint!
    lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    let contentViewController: UIViewController
    var viewPanGesture: UIPanGestureRecognizer!
    
    // MARK: Realm
    let realm = try! Realm()
    var notificationToken: NotificationToken!
    var realmTodos: Results<Todo>!
    
    // MARK: - Life Cycle
    init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        let blurViewTap = UITapGestureRecognizer(target: self, action: #selector(blurViewTapped(_:)))
        blurView.addGestureRecognizer(blurViewTap)
        blurView.isUserInteractionEnabled = true
        
        recognizePanGesture()
        todoNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
}

extension BottomSheetViewController {
    
    // MARK: - Methods
    func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.blurView.alpha = 0.7
            self.view.layoutIfNeeded()
        })
    }
    
    func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn,  animations: {
            self.blurView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func recognizePanGesture() {
        viewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPanGesture.delaysTouchesBegan = false
        viewPanGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPanGesture)
    }
    
    func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
    func blurViewAlphaWithBottomSheetTopConstaint(value: CGFloat) -> CGFloat {
        let fullBlurAlpha: CGFloat = 0.7
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        let fullBlurPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2
        let noBlurPosition = safeAreaHeight + bottomPadding
        
        if value < fullBlurPosition {
            return fullBlurAlpha
        } else if noBlurPosition < value {
            return 0.0
        }
        
        return fullBlurAlpha * (1 - ((value - fullBlurPosition) / (noBlurPosition - fullBlurPosition)))
    }
}
