
import UIKit

final class RootRouter {
	func root(_ window: inout UIWindow?, rootViewController: UIViewController) {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.rootViewController = rootViewController
	}
}
