
import UIKit


class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet var pageControl: UIPageControl!

	private var collections: [[String: String]] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()

		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: pageControl)
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .done, target: self, action: #selector(actionSkip))

        collectionView.delegate = self
        collectionView.dataSource = self
        
		collectionView.register(UINib(nibName: "OnboardingCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCell")

		pageControl.pageIndicatorTintColor = UIColor.lightGray
		pageControl.currentPageIndicatorTintColor = AppColor.Theme

		loadCollections()
	}

	// MARK: - Collections methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadCollections() {

		collections.removeAll()

		var dict1: [String: String] = [:]
		dict1["title"] = "Discover Restaurants, Recipes & more"
		dict1["description"] = "It is those feelings that drive our love of delicious food and our desire to serve you better"
		collections.append(dict1)

		var dict2: [String: String] = [:]
		dict2["title"] = "Discover Restaurants, Recipes & more"
		dict2["description"] = "It is those feelings that drive our love of delicious food and our desire to serve you better"
		collections.append(dict2)

		collections.append(dict1)
		collections.append(dict2)

		refreshCollectionView()
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionSkip() {
        let loginVC : LoginVC = LoginVC(nibName :"LoginVC",bundle : nil)
        self.navigationController?.pushViewController(loginVC, animated: true)

		dismiss(animated: true)
	}

	// MARK: - Refresh methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func refreshCollectionView() {

		collectionView.reloadData()
	}
}

// MARK:- UICollectionViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension OnboardingVC: UICollectionViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return collections.count
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
		cell.bindData(index: indexPath.item, data: collections[indexPath.row])
		return cell
	}
}

// MARK:- UICollectionViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension OnboardingVC: UICollectionViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		print("didSelectItemAt \(indexPath.row)")
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

		pageControl.currentPage = indexPath.row
	}
}

// MARK:- UICollectionViewDelegateFlowLayout
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension OnboardingVC: UICollectionViewDelegateFlowLayout {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return collectionView.frame.size
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		return UIEdgeInsets.zero
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 0
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 0
	}
}
