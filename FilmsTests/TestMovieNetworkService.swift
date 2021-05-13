//
//  TestMovieNetworkService.swift
//  FilmsTests
//
//  Created by iOS_Coder on 13.05.2021.
//

@testable import Films
import XCTest

final class MockMovieNetworkService: MovieNetworkServiceProtocol {
    private var movies: [Movie]?
    private var photos: [Photo]?

    init() {}

    init(movies: [Movie]) {
        self.movies = movies
    }

    init(photos: [Photo]) {
        self.photos = photos
    }

    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], Error>) -> ()) {
        if let movies = movies {
            completion(.success(movies))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func loadPhotos(for movieId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        if let photos = photos {
            completion(.success(photos))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

final class MockImageProxyService: ImageProxyServiceProtocol {
    private var image: UIImage?

    init() {}

    init(image: UIImage?) {
        self.image = image
    }

    func getImage(by path: String?, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        if let image = image {
            completion(.success(image))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

final class TestMovieNetworkService: XCTestCase {
    private var networkService: MovieNetworkServiceProtocol!
    private var imageProxy: ImageProxyServiceProtocol!
    private var viewModel: MovieListViewModelProtocol!
    private var movies: [Movie]!
    private var photos: [Photo]!

    override func setUp() {
        super.setUp()

        networkService = MockMovieNetworkService()
        imageProxy = MockImageProxyService()
        movies = []
        photos = []
    }

    override func tearDown() {
        super.tearDown()

        networkService = nil
        imageProxy = nil
        viewModel = nil
        movies = nil
        photos = nil
    }

    func testGetSuccessMovies() {
        let movie = Movie(
            id: 1,
            overview: "Bob",
            popularity: 2,
            posterPath: "Bod",
            releaseDate: "date",
            title: "title",
            voteAverage: 3,
            voteCount: 4
        )
        movies.append(movie)

        networkService = MockMovieNetworkService(movies: movies)

        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)

        var catchMovies: [Movie]?

        viewModel.update = { [weak self] in
            catchMovies = self?.viewModel.movies
        }

        viewModel.fetchMovies(for: .nowPlaying)

        XCTAssertNotEqual(catchMovies?.count, 0)
        XCTAssertEqual(catchMovies?.count, movies.count)
    }

    func testGetFailureMovies() {
        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)

        var catchError: Error?

        networkService.fetchMovies(category: .nowPlaying) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                catchError = error
            }
        }

        XCTAssertNotNil(catchError)
    }

//    func testGetSuccessPhotos() {
//        let photo = Photo(aspectRatio: 1, filePath: "path")
//        photos.append(photo)
//
//        networkService = MockMovieNetworkService(photos: photos)
//
//        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)
//
//        var catchPhotos: [Photo]?
//
//        networkService.loadPhotos(for: 0) { result in
//            switch result {
//            case let .success(photos):
//                catchPhotos = photos
//            case .failure:
//                break
//            }
//        }
//
//        XCTAssertNotEqual(catchPhotos?.count, 0)
//        XCTAssertEqual(catchPhotos?.count, photos.count)
//    }
//
//    func testGetFailurePhotos() {
//        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)
//
//        var catchError: Error?
//
//        networkService.loadPhotos(for: 0) { result in
//            switch result {
//            case .success:
//                break
//            case let .failure(error):
//                catchError = error
//            }
//        }
//
//        XCTAssertNotNil(catchError)
//    }

    func testGetSuccessImages() {
        let image = UIImage(systemName: "applelogo")

        imageProxy = MockImageProxyService(image: image)

        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)

        var catchImage: UIImage?

        viewModel.fetchImage(for: "path") { result in
            switch result {
            case let .success(image):
                catchImage = image
            case .failure:
                break
            }
        }

        XCTAssertEqual(catchImage, image)
    }

    func testGetFailureImages() {
        viewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxy)

        var catchError: Error?

        viewModel.fetchImage(for: "path") { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                catchError = error
            }
        }

        XCTAssertNotNil(catchError)
    }
}
