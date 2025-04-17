//
//  ArticlesViewController.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import UIKit

protocol ArticlesDisplayLogic: AnyObject {
    //    var articles: Articles.FetchArticles.ViewModel? { get }
    func displayArticles(viewModel: Articles.FetchArticles.ViewModel)
    func displayError(viewModel: Articles.PresentError.Response)
    func displayLoading(viewModel: Articles.PresentLoading.Response)
    func displayArticleDetail(_ articleDetail: ArticleDetail)
}

class ArticlesViewController: UIViewController, ArticlesDisplayLogic {
    var interactor: ArticlesBusinessLogic?
    var router: (NSObjectProtocol & ArticlesRoutingLogic & ArticlesDataStore)?
    
    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.register(EmptyArticlesCell.self, forCellWithReuseIdentifier: EmptyArticlesCell.identifier)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .persianBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Properties
    private var displayedArticles: [DisplayedArticle] = []
    
    // MARK: - Initialization
    init(interactor: ArticlesBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
        loadArticles()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = HomeStrings.articlesTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.persianBlue]
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = .persianBlue
        navigationItem.leftBarButtonItem = backButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    // MARK: - Data Loading
    private func loadArticles() {
        let request = Articles.FetchArticles.Request()
        interactor?.fetchArticles(request: request)
    }
    
    // MARK: - ArticlesDisplayLogic
    func displayLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.activityIndicator.startAnimating()
                self?.collectionView.isHidden = true
                self?.pageControl.isHidden = true
                self?.collectionView.isHidden = true
            } else {
                self?.activityIndicator.stopAnimating()
                self?.collectionView.isHidden = false
                self?.pageControl.isHidden = false
            }
        }
    }
    
    func displayArticles(viewModel: Articles.FetchArticles.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.displayedArticles = viewModel.displayedArticles
            self?.collectionView.reloadData()
            
            if viewModel.displayedArticles.isEmpty {
                self?.pageControl.isHidden = true
            } else {
                self?.pageControl.numberOfPages = viewModel.displayedArticles.count
                self?.pageControl.isHidden = false
                self?.collectionView.isHidden = false
            }
        }
    }
    
    func displayError(viewModel: Articles.PresentError.Response) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: HomeStrings.errorMessage,
                                          message: viewModel.errorMessage,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: HomeStrings.errorButton, style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    func displayLoading(viewModel: Articles.PresentLoading.Response) {
        DispatchQueue.main.async { [weak self] in
            if viewModel.isLoading {
                self?.activityIndicator.startAnimating()
                self?.collectionView.isHidden = true
                self?.pageControl.isHidden = true
            } else {
                self?.activityIndicator.stopAnimating()
                self?.collectionView.isHidden = false
                self?.pageControl.isHidden = false
            }
        }
    }
    
    func displayArticleDetail(_ articleDetail: ArticleDetail) {
        router?.routeToArticleDetail(id: articleDetail.id ?? 0)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ArticlesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedArticles.isEmpty ? 1 : displayedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if displayedArticles.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyArticlesCell.identifier, for: indexPath) as? EmptyArticlesCell else {
                    fatalError("Unable to dequeue EmptyArticlesCell")
                }
                cell.configureEmptyView()
                return cell
            }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
                fatalError("Unable to dequeue cell")
            }
        cell.configure(with: displayedArticles[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ArticlesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

// MARK: - UICollectionViewDelegate
extension ArticlesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !displayedArticles.isEmpty else { return }
        let request = Articles.DidSelectArticle.Request(id: displayedArticles[indexPath.item].id)
        interactor?.didSelectArticle(request: request)
    }
}
