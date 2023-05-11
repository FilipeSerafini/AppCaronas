//
//  GroupView.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 11/05/23.
//

import SwiftUI
import CloudKit



struct GroupView: View {
    
    @StateObject var viewModel = LiftViewModel2()
    
    @State var name: String = ""
    @State var days: String = ""
    @State var hour: String = ""
    
    var body: some View {
        VStack {
            TextField("Groups name", text: self.$name)
                .padding()
            
            TextField("Days", text: self.$days)
                .padding()
            
            TextField("Hour", text: self.$hour)
                .padding()
            
            
            Button(action: {
                guard let hour = Int(self.hour) else { return }
                let group = Group(name: self.name, days: self.days, hour: hour)
                
                self.viewModel.saveOnDataBase(group: group)
            }, label: {
                Text("Save group on database")
            })
        }
    }
}


class LiftViewModel2: ObservableObject {
    
    func saveOnDataBase(group: Group) {
        let record = CKRecord(recordType: "Group")
        record["name"] = group.name
        record["days"] = group.days
        record["hour"] = group.hour
        CloudKitUtility.save(record: record, completion: { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        })
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
