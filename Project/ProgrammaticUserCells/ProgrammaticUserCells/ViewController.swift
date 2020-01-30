import UIKit

class ViewController: UIViewController {
    
    private let users = UsersView()
    
    private var userInfo = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.users.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = users
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        navigationItem.title = "Users"
        users.collectionView.dataSource = self
        users.collectionView.delegate = self
        users.collectionView.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "userCell")
        getUserInfo()
    }
    
    private func getUserInfo() {
        UsersFetchingService.manager.getUsers { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let user):
                self.userInfo = user
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as? UserCell else {
            fatalError("could not downcast UserCell")
        }
        let userData = userInfo[indexPath.row]
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 7
        cell.configureCell(for: userData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.95
        return CGSize(width: itemWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let users = userInfo[indexPath.row]
        let detailSotryboard = UIStoryboard(name: "UserDetail", bundle: nil)
        guard let detailVC = detailSotryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailVC.detailUserInfo = users
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

