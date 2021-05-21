//
//  TestMovieDetailModule.swift
//  FilmsTests
//
//  Created by iOS_Coder on 14.05.2021.
//

@testable import Films
import XCTest

final class TestMovieDetailModule: XCTestCase {
    private var networkService: MovieNetworkServiceProtocol!
    private var imageProxy: ImageProxyServiceProtocol!
    private var viewModel: MovieDetailsViewModelProtocol!
    private var movie: Movie!
    private var images: [UIImage?]!
    private var photos: [Photo]!

    override func setUp() {
        super.setUp()

        networkService = MockMovieNetworkService()
        imageProxy = MockImageProxyService()
        images = []
        photos = []
        movie = Movie(
            id: 1,
            overview: "Bob",
            popularity: 2,
            posterPath: "Bod",
            releaseDate: "date",
            title: "title",
            voteAverage: 3,
            voteCount: 4
        )
    }

    override func tearDown() {
        super.tearDown()

        networkService = nil
        imageProxy = nil
        viewModel = nil
        movie = nil
        photos = nil
        images = nil
    }

    func testGetSuccessImages() {
        let photo = Photo(aspectRatio: 1, filePath: "path")
        photos.append(photo)
        networkService = MockMovieNetworkService(photos: photos)

        let image = UIImage(systemName: "xmark")
        images.append(image)
        imageProxy = MockImageProxyService(image: image)

        viewModel = MovieDetailsViewModel(movie: movie, networkService: networkService, imageProxy: imageProxy)

        viewModel.setMovie()

        let catchImages: [UIImage?]? = viewModel.imageArray

        XCTAssertEqual(catchImages, images)
    }

    func testGetFailureImages() {
        var catchError: Error?

        imageProxy.getImage(by: "path") { result in
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
