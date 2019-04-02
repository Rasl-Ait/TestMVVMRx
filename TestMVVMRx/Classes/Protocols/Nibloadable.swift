
import UIKit

protocol Nibloadable: class {
	static var nib: UINib { get }
}

extension Nibloadable {
	static var nib: UINib {
		return UINib(nibName: name, bundle: Bundle(for: self))
	}
	
	static var name: String {
		return String(describing: self)
	}
}

extension Nibloadable where Self: UIView {
	static func loadFromNib() -> Self {
		guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else { fatalError("error") }
		
		return view
	}
}

extension UIView: Nibloadable {}
