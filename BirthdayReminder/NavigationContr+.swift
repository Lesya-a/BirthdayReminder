import UIKit

extension BirthdaysVC {
    func centerTitleNB() {
        for navItem in(self.navigationController?.navigationBar.subviews)! {
            for itemSubView in navItem.subviews {
                if let largeLabel = itemSubView as? UILabel {
                    largeLabel.center = CGPoint(
                        x: navItem.bounds.width/2,
                        y: navItem.bounds.height/2
                    )
                    return
                }
            }
        }
    }
}

extension AddBirthdayVC {
    func centerTitleNB() {
        for navItem in(self.navigationController?.navigationBar.subviews)! {
            for itemSubView in navItem.subviews {
                if let largeLabel = itemSubView as? UILabel {
                    largeLabel.center = CGPoint(
                        x: navItem.bounds.width/2,
                        y: navItem.bounds.height/2
                    )
                    return
                }
            }
        }
    }
}
