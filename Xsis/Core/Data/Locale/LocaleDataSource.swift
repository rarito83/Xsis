//
//  LocaleDataSource.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  func getFavoriteMovie() -> AnyPublisher<[MovieEntity], Error>
  func isFavoriteMovie(id: Int) -> AnyPublisher<Bool, Error>
  func addMovieToFavorite(movie: MovieEntity) -> AnyPublisher<Bool, Error>
  func deleteMovieFromFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func getFavoriteMovie() -> AnyPublisher<[MovieEntity], Error> {
      return Future<[MovieEntity], Error> { completion in
          guard let realm = self.realm else {
              completion(.failure(DatabaseError.invalidInstance))
              return
          }
          
          let movie: Results<MovieEntity> = {
              realm.objects(MovieEntity.self).sorted(byKeyPath: "id")
          }()
          completion(.success(movie.toArray(ofType: MovieEntity.self)))
      }.eraseToAnyPublisher()
  }
  
  private func getObject(id: Int) -> MovieEntity? {
      return realm?.object(ofType: MovieEntity.self, forPrimaryKey: id)
  }
  
  func isFavoriteMovie(id: Int) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          guard let _ = self.realm else {
              completion(.failure(DatabaseError.invalidInstance))
              return
          }

          let result = self.getObject(id: id)
          completion(.success(result != nil))
      }.eraseToAnyPublisher()
  }
  
  func addMovieToFavorite(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          guard let realm = self.realm else {
              completion(.failure(DatabaseError.invalidInstance))
              return
          }
          
          do {
              try realm.write {
                  realm.add(movie)
              }
              completion(.success(true))
          } catch {
              completion(.failure(DatabaseError.requestFailed))
          }
      }.eraseToAnyPublisher()
  }
  
  func deleteMovieFromFavorite(id: Int) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          guard let realm = self.realm else {
              completion(.failure(DatabaseError.invalidInstance))
              return
          }
          
          do {
              try realm.write {
                  let object = self.getObject(id: id)!
                  realm.delete(object)
              }
              completion(.success(true))
          } catch {
              completion(.failure(DatabaseError.requestFailed))
          }
      }.eraseToAnyPublisher()
  }
}

extension Results {
  
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
}
