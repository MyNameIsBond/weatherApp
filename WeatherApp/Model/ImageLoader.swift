
import UIKit

struct ImageFetcher {
  func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      completion(UIImage(data: data))
    }.resume()
  }
}
