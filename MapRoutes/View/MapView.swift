

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Custom Pins.....
            
            // Excluding User Blue Circle...
            
            //if annotation.isKind(of: MKUserLocation.self){return nil}
       // reuseIdentifier: "PIN_VIEW"
            //pinAnnotation.tintColor = .red
            //pinAnnotation.animatesDrop = true
            //pinAnnotation.canShowCallout = true
            
            return MKPinAnnotationView()
        }
        
        
    }
}
