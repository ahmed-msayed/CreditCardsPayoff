
import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class OnboardingCell: UICollectionViewCell {

	@IBOutlet var imageView: UIImageView!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelDescription: UILabel!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(index: Int, data: [String: String]) {

		guard let title = data["title"] else { return }
		guard let description = data["description"] else { return }

		imageView.sample("Food", "Sweets", index + 1)
		labelTitle.text = title
		labelDescription.text = description
	}
}
