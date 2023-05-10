//
//  GroupCRUD.swift
//  AppCaronas
//
//  Created by Filipe Serafini on 10/05/23.
//

import SwiftUI
import CloudKit
import Combine

//recor[] ainda eh hardcoded, poderia criar uma struct com essas variaves e chamar elas


protocol CloudKitItemProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get  }
}

struct FruitModel: Hashable, CloudKitItemProtocol {
    let name: String
    let imageURL: URL?
    let record: CKRecord
    let count: Int
    
    init?(record: CKRecord) {
        guard let name = record["name"] as? String else { return nil }
        self.name = name
        let imageAsset = record["image"] as? CKAsset
        self.imageURL = imageAsset?.fileURL
        let count = record["count"] as? Int
        self.count = count ?? 0
        self.record = record
    }
    
    init?(name: String, imageURL: URL?, count: Int?) {
        let record = CKRecord(recordType: "Fruits")
        record["name"] = name
        if let url = imageURL {
            let asset = CKAsset(fileURL: url) //converte para um CKAsset
            record["image"] = asset //fazer upload do CKAsset como parte do nosso modelo no cloudkit
        }
        
        if let count = count {
            record["count"] = count
        }
        
        self.init(record: record)
    }
    
    func update(newName: String) -> FruitModel? {
        let record = record
        record["name"] =  newName
        return FruitModel(record: record)
    }
}


class CloudKitCRUDBootcampViewModel: ObservableObject {
     
    @Published var text: String = ""
    @Published var fruits: [FruitModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchItems()
    }
    
    //o que fazer quando apertar o botao Add
    func addButtonPressed() {
        guard !text.isEmpty else { return }
        addItem(name: text)
    }
    
    //adicionar item (criar o item)
    private func addItem(name: String) {
         
        //para adicionar imagens:
        //primeiro precisamos adicionar a imagem ao FileManager e pegar a url dela, para depois
        //usar essa url como asset para nosso dado
        guard
            let image = UIImage(named: "avatar"), //coloca a imagem no codigo
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("avatar.jpg"), //coloca a imagem no filemanager
            let data = image.jpegData(compressionQuality: 1.0) else { return } //converte a imagem para dado

        do {
            try data.write(to: url)
            guard let newFruit = FruitModel(name: name, imageURL: url, count: 5) else { return }
            
            CloudKitUtility.add(item: newFruit) { result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.fetchItems()
                }
            }
        } catch let error {
            print(error)
        }
        
        
    }
    
    //atualizar os itens na tela, para isso precisa puxar do banco
    func fetchItems() {
        
        //criar operacao de query (CKQueryOperation, que conforma com CKDatabaseOperation)
        //essa operacao entra no banco e pega os dados buscados
        let predicate = NSPredicate(value: true )
        let recordType = "Fruits"
        
        //nessa chamada que definimos o que queremos pegar do banco, basta mudar o recordType e o tipo de rerturnedItems
        CloudKitUtility.fetch(predicate: predicate, recordType: recordType)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.fruits = returnedItems
            }
            .store(in: &cancellables)
    }
    
    //puxar do banco a informacao
    //para pegar algo do banco, precisamos adicionar uma operacao (por ex: operacao de busca)
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    //logica eh a mesma que adicionar, mas pegamos um record ja existente, mudamos o que queremos e salvamos de volta (funcao save)
    func updateItem(fruit: FruitModel) {
        guard let newFruit = fruit.update(newName: "NOVO NOME!!") else { return }
        
        CloudKitUtility.update(item: newFruit) { [weak self] result in
            print("UPDATE COMPLETED")
            self?.fetchItems()
        }
    }
    
    //acessa o array de frutas a partir de um index, pega a fruta, pega o record
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let fruit = fruits[index]
        let record = fruit.record
        
        CloudKitUtility.delete(item: fruit)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] success in
                print("DELETE IS: \(success)")
                self?.fruits.remove(at: index)
                
            }
            .store(in: &cancellables)
    }
}

struct CloudKitCRUDBootcamp: View {
    
    @StateObject private var vm = CloudKitCRUDBootcampViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                textField
                addButton
                
                List {
                    ForEach(vm.fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name)
                            
                            if let url = fruit.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }

                        }
                        .onTapGesture {
                            vm.updateItem(fruit: fruit )
                        }
                    }
                    .onDelete(perform: vm.deleteItem)
                }
                .listStyle(PlainListStyle())
                
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CloudKitCRUDBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCRUDBootcamp()
    }
}

extension CloudKitCRUDBootcamp {
    
    private var header: some View {
        Text("CloudKit CRUD ☁️☁️☁️")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Add something here...", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View {
        Button {
            vm.addButtonPressed()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
}
