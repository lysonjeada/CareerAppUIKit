//
//  ArticleDetailViewController.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 14/04/25.
//

import UIKit

protocol ArticleDetailDisplayLogic: AnyObject {
    func displayArticleDetail(_ viewModel: ArticlesDetail.FetchArticle.ViewModel)
    func displayError(_ error: String)
    func displayLoading(_ isLoading: Bool)
}

class ArticleDetailViewController: UIViewController, ArticleDetailDisplayLogic {
    var interactor: ArticleDetailBusinessLogic?
    var id: Int
//    var router: (NSObjectProtocol & ArticleDetailRoutingLogic & ArticleDetailDataPassing)?
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var metaDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var readingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bodyWebView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchArticleDetail()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // Configura o botão de voltar
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(backButtonTapped))
        backButton.tintColor = .persianBlue
        navigationItem.leftBarButtonItem = backButton
        
        // Remove o título do botão de voltar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Remove o título da navigation bar
        navigationItem.title = "Detalhe"
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.backgroundColor = .white
        title = "Article Details"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorStackView)
        contentView.addSubview(metaDataStackView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bodyWebView)
        view.addSubview(activityIndicator)
        
        authorStackView.addArrangedSubview(authorImageView)
        authorStackView.addArrangedSubview(authorNameLabel)
        
        metaDataStackView.addArrangedSubview(publishDateLabel)
        metaDataStackView.addArrangedSubview(readingTimeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            authorStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            authorStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            metaDataStackView.topAnchor.constraint(equalTo: authorStackView.bottomAnchor, constant: 8),
            metaDataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            metaDataStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: metaDataStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bodyWebView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            bodyWebView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyWebView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyWebView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchArticleDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        interactor?.fetchArticleDetail(id: id)
    }
    
    // MARK: - ArticleDetailDisplayLogic
    func displayArticleDetail(_ viewModel: ArticlesDetail.FetchArticle.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            
            let displayedDetail = viewModel.displayedArticleDetail
            
            self?.titleLabel.text = displayedDetail.title
            self?.authorNameLabel.text = displayedDetail.authorName
            self?.publishDateLabel.text = displayedDetail.readablePublishDate
            self?.readingTimeLabel.text = "\(displayedDetail.readingTimeMinutes) min read"
            self?.descriptionLabel.text = displayedDetail.description
            
            if let coverImageURL = displayedDetail.coverImageURL, let url = URL(string: coverImageURL) {
                self?.loadImage(from: url, into: self?.coverImageView ?? .init())
            }
            
            if let authorImageURL = displayedDetail.authorProfileImage, let url = URL(string: authorImageURL) {
                self?.loadImage(from: url, into: self?.authorImageView ?? .init())
            }
            
            if !displayedDetail.bodyHtml.isEmpty {
                self?.bodyWebView.loadHTMLString(displayedDetail.bodyHtml, baseURL: nil)
            }
        }
    }
    
    func displayError(_ error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    func displayLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.activityIndicator.startAnimating()
                self?.coverImageView.isHidden = true
            } else {
                self?.activityIndicator.stopAnimating()
                self?.coverImageView.isHidden = false
            }
        }
    }
    
    // MARK: - Helper Methods
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
    }
}
