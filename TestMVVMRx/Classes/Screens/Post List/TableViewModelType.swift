
import Foundation
import RealmSwift

protocol PostListViewModelType {
	func resultsItems() -> Results<PostModel>
}
