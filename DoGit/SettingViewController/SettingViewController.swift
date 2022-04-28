//
//  SettingViewController.swift
//  DoGit
//
//  Created by neuli on 2022/04/27.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    let settingMenu: [String] = ["이름 수정"]
    let developerMenu: [String] = ["문의하기", "개발자 정보"]
    
    var collectionView: UICollectionView!
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
    }
}

extension SettingViewController {
    
    func configureCollectionView() {
        
        view.backgroundColor = .backgroundColor
        
        let listLayout = listLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = "\(item)"
            cell.contentConfiguration = content
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = Snapshot()
        snapshot.appendSections([.setting, .developer])
        snapshot.appendItems(settingMenu, toSection: .setting)
        snapshot.appendItems(developerMenu, toSection: .developer)
        
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
        
        collectionView.delegate = self
    }
    
    func configureUI() {
        
        // MARK: navigation bar
        let barAttribute = [NSAttributedString.Key.font : UIFont.Font.regular16]
        let titleAttribute = [NSAttributedString.Key.font : UIFont.Font.bold18]
        
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = titleAttribute
        
        let cancelBarButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(didCancelAdd(_:)))
        cancelBarButton.tintColor = .mainColor
        cancelBarButton.setTitleTextAttributes(barAttribute, for: .normal)
        navigationItem.leftBarButtonItem = cancelBarButton
        
        // MARK: collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func presentSetNameViewControllerModal() {
        let setNameViewController = SetNameViewController()
        self.present(setNameViewController, animated: true, completion: nil)
    }
    
    func openDeveloperSite() {
        if let url = URL(string: "https://github.com/NEULiee") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            presentSetNameViewControllerModal()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            sendMail()
        } else {
            openDeveloperSite()
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func sendMail() {
        
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = "이곳에 내용을 작성해주세요."
            composeViewController.setToRecipients(["asdfz888@naver.com"])
            composeViewController.setSubject("[두깃] 문의 및 오류 제보")
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
