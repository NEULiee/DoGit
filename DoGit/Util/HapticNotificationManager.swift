//
//  HapticNotificationManager.swift
//  DoGit
//
//  Created by neuli on 2022/12/22.
//

import UIKit

struct HapticNotificationManager {
    static let hapticNotification = UINotificationFeedbackGenerator()
    
    static func occur(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        hapticNotification.notificationOccurred(notificationType)
    }
}
