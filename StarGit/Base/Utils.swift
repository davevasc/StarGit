//
//  Utils.swift
//  StarGit
//
//  Created by David Vicente on 30/3/22.
//

import Foundation
import UIKit

class Utils {
    static func show(Message message: String, WithTitle title: String, InViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIImageView {
    func load(url: URL) {
        //GCD background thread
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    // Load image in the main thread
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIColor {

    @objc func soft(by alpha: CGFloat = 0.2) -> UIColor {
        return self.withAlphaComponent(alpha)
    }

}
