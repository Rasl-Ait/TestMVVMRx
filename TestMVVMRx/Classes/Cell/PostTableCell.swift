//
//  PostTableCell.swift
//  TestMVVMRx
//
//  Created by rasl on 25/03/2019.
//  Copyright © 2019 rasl. All rights reserved.
//

import UIKit
import RealmSwift

class PostTableCell: UITableViewCell {
	@IBOutlet private weak var indexLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var button: UIButton!
	
	static var height: CGFloat { return 80 }
	
	var model: PostModel? {
		didSet {
			configure(with: model)
		}
	}
	
	var onToggleCompleted: ItemClosure<PostModel>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		selectionStyle = .none
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	@IBAction private func toggleCompleted() {
		guard let item = model else { fatalError("Missing Post Item") }
		onToggleCompleted?(item)
	}
	
	func configure(with viewModel: PostModel?) {
		guard let model = viewModel else { return }
		indexLabel.text = "\((model.id))."
		
		titleLabel.attributedText = NSAttributedString(
			string: model.title.capitalized,
			attributes: model.isCompleted ? [.strikethroughStyle: true, .strikethroughColor: UIColor.red] : [:])
		
		button.setTitle(model.isCompleted ? "☑️": "⏺", for: .normal)
	}
}
