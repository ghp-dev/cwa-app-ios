// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import UIKit

class HomeSubmitCellConfigurator: CollectionViewCellConfigurator {
	var submitAction: (() -> Void)?
	var store: Store?

	func configure(cell: SubmitCollectionViewCell) {
		cell.delegate = self
		cell.iconImageView.image = UIImage(named: "Hand_with_phone")
		cell.titleLabel.text = AppStrings.Home.submitCardTitle
		cell.bodyLabel.text = AppStrings.Home.submitCardBody
		let buttonTitle = AppStrings.Home.submitCardButton
		cell.contactButton.setTitle(buttonTitle, for: .normal)
		guard let buttonLabel = cell.contactButton.titleLabel else { return }
		buttonLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .semibold))
		buttonLabel.adjustsFontForContentSizeCategory = true
		buttonLabel.lineBreakMode = .byWordWrapping
	}
}

extension HomeSubmitCellConfigurator: SubmitCollectionViewCellDelegate {
	func submitButtonTapped(cell _: SubmitCollectionViewCell) {
		submitAction?()
	}
}

// ATTENTION: WORK IN PROGRESS!
// TODO: Move these classes to appropriate files and check if they can be integrated into the HomeSubmitCell flow.

class ExposureSubmissionCell: HomeCardCollectionViewCell {}

class HomeExposureSubmissionStateCellConfigurator: CollectionViewCellConfigurator {

	// MARK: - Controllers from which we grab the screens for reuse.

	let sVC = AppStoryboard
		.exposureSubmission
		.initiate(viewControllerType: ExposureSubmissionSuccessViewController.self)


	func configure(cell: ExposureSubmissionCell) {
		// Instantiate embedded view.
		// This needs to be called in order for us to be able
		// to reuse the already existing tableview / screens.
		// Otherwise the tableview will always be nil.
		sVC.viewDidLoad()

		if let table = sVC.tableView {
			table.removeFromSuperview()
			cell.contentView.addSubview(table)
			table.isScrollEnabled = false

			// MARK: - Constraint setting.
			table.translatesAutoresizingMaskIntoConstraints = false
			table.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
			table.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
			table.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
			table.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
		}
	}
}
