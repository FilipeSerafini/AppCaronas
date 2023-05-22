//
//  UberMapViewRepresentable.swift
//  Uber2.0
//
//  Created by Gustavo Zahorcsak Matias Silvano on 08/05/23.
//

import SwiftUI
import MapKit
import ClockKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @Binding var controle : Int
    @Binding var conjunto : Set<RideGroup>
    @Binding var vezes : Int
    @Binding var ender : CLLocationCoordinate2D
    @EnvironmentObject var gc: RideGroupCRUD
    @State var cont = 0

    var formaHome : Bool
    
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        //conjunto.insert("Nao sei")
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocationCoordinate {

                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyLine(withDestinationCoordinate: coordinate)
                context.coordinator.verificaEnderecos(withDestinationCoordinate: coordinate)
                 
                
                
            }
            
        }

//        if mapState == .noInput {
//            context.coordinator.clearMapViewAndRecenterOnUserLocation()
//        }
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self, controle: controle)
    }
    
}

struct aux : View{
    
    var body: some View{
        Text("a")
    }
}

extension UberMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        var dist : CLLocationDistance?
        var controle : Int

        
        // MARK: - Lifecycle
        
        init(parent: UberMapViewRepresentable, controle: Int) {
            self.parent = parent
            self.controle = parent.controle
            super.init()
        }
        
        // MARK: - MKMapViewDeLegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .blue
            polyline.lineWidth = 6
            return polyline
        }
        
        // MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func verificaEnderecos(withDestinationCoordinate coordinates: CLLocationCoordinate2D){
            if parent.formaHome == true {
               // parent.gc.fetchItems()
                
                
            
               /* getDestinationRoute(from: CLLocationCoordinate2D(latitude: -30.06000, longitude: -51.17165), to: coordinates) { route in
                print("%")
                if route.distance < 2400 && route.distance > 0 {
                    print("*")
                    self.parent.conjunto.insert(self.parent.enderecos[0])
                    

                }
            }*/
            
                for group in parent.gc.groups{
                    print("Grupo ", group.finalAdress, group.initialAdress)
                    let aux1 = CLLocationCoordinate2D(latitude: CLLocationDegrees(group.userAdressLat) ?? 0.0 , longitude: CLLocationDegrees(group.userAdressLong) ?? 0.0)
                    
                    let aux2 = CLLocationCoordinate2D(latitude: -30.06000, longitude: -51.17165)
                    
                    getDestinationRoute(from: (aux1), to: (aux2)) { route in
                    let cont = route.polyline.pointCount
                    
                    
                    self.getDestinationRoute(from: (aux1), to: aux2) { routes in
                        print("%")
                        if routes.distance < 2700 && routes.distance > 0 {
                            print("*")
                            self.parent.conjunto.insert(group)
                            print("ADICIONOU", group.initialAdress)

                            
                        }
                        
                    }
                    
                    let quantidade = self.parent.gc.groups.count
                        for x in 0..<Int(cont - 1)/(12 + (quantidade))  {
                            if x * (12 + (quantidade)) <= route.polyline.pointCount - 1{
                                let start = route.polyline.points()[Int(x)*(12 + (quantidade))]
                            
                            // Cria placemarks para cada extremidade do segmento
                            
                            
                            self.getDestinationRoute(from: start.coordinate, to: coordinates){ routes in
                                print("%")
                                
                                if routes.distance < 2700 && routes.distance > 0 {
                                    print("*")
                                    self.parent.conjunto.insert(group)
                                    print("ADICIONOU", group.initialAdress)
                                    
                                    
                                }
                            }
                            
                            
                            
                        }
                        
                        
                    }
                }
                    
                }
            }
            
            
        }
        
        func configurePolyLine(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            //guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute(from: CLLocationCoordinate2D(latitude: -30.05991, longitude: -51.17169), to: coordinate) { route in
                self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
                self.parent.mapView.addOverlay(route.polyline)
                
            }
        }
        
        func getDestinationRoute(from origem: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            print("#")
            let origPlacemark = MKPlacemark(coordinate: origem)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: origPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { response, error in
                if let error = error {
                    print("ERROOOO: Failed to get directions with error \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return }
                completion(route)
                self.dist = route.distance
                
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
    
    
    
}


