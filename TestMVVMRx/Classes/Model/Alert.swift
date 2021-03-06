
import UIKit

struct Alert {
	static func showBasicAlert(_ vc: UIViewController, title: String?, message: String? ) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		DispatchQueue.main.async {
			vc.present(alert, animated: true, completion: nil)
		}
	}
}
