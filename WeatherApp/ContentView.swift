
import SwiftUI
import CoreLocation
struct ContentView: View {
  @StateObject private var locationManager = LocationManager()
  
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Text("Last location: \(locationManager.lastLocation?.coordinate.latitude ?? 0), \(locationManager.lastLocation?.coordinate.longitude ?? 0)")
        }
        .padding()
        .onAppear {
          locationManager.requestLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
