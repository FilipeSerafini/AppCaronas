//
//  RouteSelectionView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 13/05/23.
//

import SwiftUI

struct AcademyView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 82, height: 24)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            Text("Academy")
        }
    }
}

struct AddressBarView: View {
    var body: some View {
        NavigationLink {
            AddressSearchView()
        } label: {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 260, height: 25)
                    .foregroundColor(Color(.lightGray))
                Text(" Para")
                    .foregroundColor(.black)
            }
        }
    }
}

struct RouteSelectionView: View {
    @Namespace private var animation
<<<<<<< HEAD
    @State var swapped = false
=======
    @State var fromAcademyToLocation = false
    @State var selectedDate: Date = Date()
>>>>>>> origin/dev
    
    var body: some View {
        
        VStack (alignment: .center){
            HStack {
                Image(systemName: "arrow.up.arrow.down")
                    .foregroundColor(.black)
                    .coordinateSpace(name: "start")
                    .onTapGesture {
                        withAnimation {
                            fromAcademyToLocation.toggle()
                        }
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
                    if (!fromAcademyToLocation) {
                        AcademyView()
                            .matchedGeometryEffect(id: "academy", in: animation)
                        AddressBarView()
                            .matchedGeometryEffect(id: "addressBar", in: animation)
                    } else {
                        AddressBarView()
                            .matchedGeometryEffect(id: "addressBar", in: animation)
                        AcademyView()
                            .matchedGeometryEffect(id: "academy", in: animation)
                    }
                }
            }
        }
    }
}

struct RouteSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RouteSelectionView()
    }
}
