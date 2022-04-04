//
//  Utils.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import Foundation
import UIKit
/** Updated 03-04-2022 */
import Kingfisher

// MARK: - Custom Utilities
/** Updated 03-04-2022 */
extension UIViewController {
    func show(Title title: String, Message message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
//class Utils {
//    static func show(Message message: String, WithTitle title: String, InViewController viewController: UIViewController) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        viewController.present(alertController, animated: true, completion: nil)
//    }
//}

// MARK: - Help for load URL image async
/** Updated 03-04-2022 */
extension UIImageView {
    func load(url: URL) {
        self.kf.setImage(with: url)
    }
}
//extension UIImageView {
//    func load(url: URL) {
//        //GCD background thread
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    // Load image in the main thread
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

// MARK: - Custom Colors
extension UIColor {
    @objc func soft(by alpha: CGFloat = 0.2) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}
