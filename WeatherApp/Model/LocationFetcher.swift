
import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() async {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager error: \(error.localizedDescription)")
    }
}

extension LocationManager {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
      manager.startUpdatingLocation()
    case .denied, .restricted:
      print("Location access denied or restricted")
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    @unknown default:
      fatalError("unknown authorization status")
    }
  }
}

