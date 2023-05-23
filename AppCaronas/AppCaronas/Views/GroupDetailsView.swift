//
//  GroupDetailsView.swift
//  AppCaronas
//
//  Created by Thiago Defini on 15/05/23.
//

import SwiftUI
import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 6
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

struct MapView: UIViewRepresentable {
    var sourceLocation : CLLocationCoordinate2D
    var destinationLocation: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays) // Remove overlays anteriores
        mapView.removeAnnotations(mapView.annotations)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .walking
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print("Error getting directions: \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: ((sourceLocation.latitude + destinationLocation.latitude) / 2 ), longitude: ((sourceLocation.longitude + destinationLocation.longitude) / 2)), span: MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045)), animated: true)
            
            let startAnnotation = MKPointAnnotation()
            startAnnotation.coordinate = self.sourceLocation
            mapView.addAnnotation(startAnnotation)
            
            let endAnnotation = MKPointAnnotation()
            endAnnotation.coordinate = self.destinationLocation
            mapView.addAnnotation(endAnnotation)
            
        }
    }
    
    func makeCoordinator() -> MapViewDelegate {
        MapViewDelegate()
    }
}

struct GroupDetailsView: View {
    @EnvironmentObject var gc: RideGroupCRUD
    @Environment(\.dismiss) var dismiss
    
    var group: RideGroup
    
    var body: some View {
        ScrollView {
            Group {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack (alignment: .center){
                        HStack {
                            VStack{
                                Spacer()
                                Text(group.hour)
                                Spacer()
                            }
                            
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                VStack(spacing: 4) {
                                    Circle()
                                        .frame(width: 2)
                                    Circle()
                                        .frame(width: 2)
                                    Circle()
                                        .frame(width: 2)
                                }
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.blue)
                                    .coordinateSpace(name: "end")
                            }
                            
                            VStack(alignment: .leading, spacing: 24) {
                                if group.initialAdress == "Academy"{
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 82, height: 24)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                        Text("Academy")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    ZStack{
                                        Text(group.finalAdress)
                                        
                                    }
                                }else{
                                    ZStack{
                                        Text(group.initialAdress)
                                        
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .frame(width: 82, height: 24)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.gray, lineWidth: 1)
                                                
                                            )
                                        Text("Academy")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(30)
                        
                        
                    }
                }
                
                Divider()
                    .frame(minHeight: 5)
                    .background(Color(.lightGray))
                    .opacity(0.5)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                    VStack{
                        
                        
                        WeekView(group: group,size: 30)
                        HStack{
                            Text("\(group.type.typeImage) \(group.type.descriptionDetailed)")
                                .padding(.leading, 30)
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    .padding(.vertical, 20)
                }
                
                Divider()
                    .frame(minHeight: 5)
                    .background(Color(.lightGray))
                    .opacity(0.5)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                    VStack{
                        HStack{
                            Text("Participantes")
                                .font(Font.custom("SF Pro Text", size: 14))
                                .foregroundColor(Color(.gray))
                            
                            Spacer()
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(.green)
                            Text("\(group.members.count)")
                        }
                        .padding(.bottom, 15)
                        HStack{
                            ForEach(group.membersNames, id: \.self){ memberName in
                                VStack{
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundColor(Color(.lightGray))
                                    Text(memberName)
                                        .lineLimit(2)
                                }
                                .frame(width: 60, height: 80)
                                .padding(.horizontal, 10)
                            }
                        }
                    }.padding()
                    
                }
                
                Divider()
                    .frame(minHeight: 5)
                    .background(Color(.lightGray))
                    .opacity(0.5)
            }
            
            Spacer()
            
            Group {
                
                MapView(sourceLocation: CLLocationCoordinate2D(latitude: CLLocationDegrees(group.userAdressLat)!, longitude: CLLocationDegrees(group.userAdressLong)!), destinationLocation: CLLocationCoordinate2D(latitude: CLLocationDegrees(-30.05985), longitude: CLLocationDegrees(-51.17175))).frame(height: 200)
                Text("⚠️ O Mapa tem limitações para a rota. Caso a rota não esteja aparecendo, espere 60 seg, volte e entre nesse card novamente!").font(.system(size: 10))
                
                Divider()
                    .frame(minHeight: 5)
                    .background(Color(.lightGray))
                    .opacity(0.5)
                
                if group.admin == UserCRUD.getUserID() {
                    Button{
                        
                        gc.deleteItem(group)
                        dismiss()
                    }label: {
                        Text("Excluir Grupo")
                            .font(Font.custom("SF Pro Text", size: 15))
                            .lineLimit(1)
                            .frame(width: 150, height: 40)
                            .foregroundColor(.white)
                            .background(.red)
                    }
                    .cornerRadius(10)
                    
                }
            }
            
            
        }
        .navigationBarTitle(group.initialAdress)
        .navigationBarTitleDisplayMode(.inline)
        //        .background(.gray)
        .toolbar{
            
            if !group.members.contains(UserCRUD.getUserID()){
                Button{
                    
                    let newUsername = UserCRUD.getUserName()
                    let newUserID = UserCRUD.getUserID()
                    
                    gc.updateItem(group: group, newMemberID: newUserID, newMemberName: newUsername)
                    
                    
                }label: {
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                    //                    .padding(.top, 50)
                        .foregroundColor(.green)
                }
            } else {
                
                Button{
                    
                    let newUsername = UserCRUD.getUserName()
                    let newUserID = UserCRUD.getUserID()
                    
                    gc.removeParticipant(group: group, newMemberID: newUserID, newMemberName: newUsername)
                    
                    
                } label: {
                    Image(systemName: "person.badge.minus")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                }
                
            }
            
        }
    }
}

struct GroupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailsView(group: g1)
    }
}
