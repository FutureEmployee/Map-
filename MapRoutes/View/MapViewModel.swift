
import SwiftUI
import MapKit
import CoreLocation
import WeatherKit
/// All Map Data Goes Here....


class MapViewModel:  NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var mapView = MKMapView()
    
        ///region...
    @Published var region : MKCoordinateRegion!
    // Based On Location It Will Set Up....
    
    // Alert...
    
    @Published var permissionDenied = false
    
    // Map Type...
    @Published var mapType : MKMapType = .standard
    
    // SearchText...
    @Published var searchTxt = ""
    // Searched Places...
    @Published var places : [Place] = []
    
    // Updating Map Type...
    
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus Location...
    
    func focusLocation(){
        guard let _ = region else{return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search Places...
    
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        //Fetch...
        MKLocalSearch(request: request).start {
            
       //     guard let result = response else{return}
            
    Mself.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    // Pick Search Result...
    func selectPlace(place: Place){
        // Showing Pin On Map....
        
        searchTxt = ""
        
        guard let coordinate = place.place.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Names"
        
        // Removing all Old Ones...
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        // Moving Map to That Location...
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000 )
        
       //  mapView.setRegion(CoordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        // Moving Map To That Location...
        
       // let coordinateRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000))
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Permissions...
    
        switch manager.authorizationStatus {
        case .notDetermined:
            // requesting....
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            /// If Permission Given...
            manager.requestLocation()
        default:
            ()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        //error...
        print(error.localizedDescription)
    }
    
    // Getting user Region....
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else{return}
            
            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
          
                // Updating Map....
            self.mapView.setRegion(self.region, animated: true)
            self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        }
    }




