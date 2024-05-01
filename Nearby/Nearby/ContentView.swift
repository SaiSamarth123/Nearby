//
//  ContentView.swift
//  Nearby
//
//  Created by Sarthak Patipati on 4/16/24.
//

import SwiftUI
import Kingfisher
import MapKit

struct ContentView: View {
    @StateObject private var factFetcher = FactFetcher()

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if factFetcher.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                        Text("Loading facts...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(factFetcher.facts) { fact in
                            NavigationLink(destination: DetailView(fact: fact)) {
                                FactTile(fact: fact)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Nearby")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct FactTile: View {
    var fact: Fact

    var body: some View {
        VStack {
            KFImage(URL(string: fact.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(8)

            Text(fact.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}

struct DetailView: View {
    var fact: Fact
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(fact.description)
                    .padding()
                
                MapView(coordinate: CLLocationCoordinate2D(latitude: fact.latitude, longitude: fact.longitude))
                    .frame(height: 300)
                
                Link("Learn More", destination: URL(string: fact.url)!)
                    .padding()
            }
        }
        .navigationTitle(fact.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: [MapAnnotationItem(coordinate: coordinate)]) { item in
            MapPin(coordinate: item.coordinate)
        }
    }
}

struct MapAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//import SwiftUI
//import Kingfisher
//
//struct ContentView: View {
//    @StateObject private var factFetcher = FactFetcher()
//    
//
//    let columns = [
//        GridItem(.adaptive(minimum: 150))
//    ]
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                if factFetcher.isLoading {
//                    VStack {
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                            .scaleEffect(1.5)
//                        Text("Loading facts...")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                    }
//                } else {
//                    LazyVGrid(columns: columns, spacing: 20) {
//                        ForEach(factFetcher.facts) { fact in
//                            NavigationLink(destination: Text(fact.description)) {
//                                FactTile(fact: fact)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Nearby")
//            .navigationBarTitleDisplayMode(.inline)
//            .padding()
////            .onAppear {
////                notificationManager.requestAuthorization() // Request notification permission on appear
////                locationManager.startUpdatingLocation // Start updating location on appear
////                        }
//        }
//    }
//}
//
//struct FactTile: View {
//  var fact: Fact
//
//  var body: some View {
//    VStack {
//      KFImage(URL(string: fact.imageUrl))
//        .resizable()
//        .aspectRatio(contentMode: .fill)
//        .frame(width: 100, height: 100)
//        .clipped()
//        .cornerRadius(8)
////        .placeholder { url in
////          KFImage(url: URL(string: "your_placeholder_image_url"))
////            .resizable()
////            .aspectRatio(contentMode: .fill)
////            .frame(width: 100, height: 100)
////            .clipped()
////        }
//
//      Text(fact.title)
//        .fontWeight(.semibold)
//        .multilineTextAlignment(.center)
//        .padding()
//    }
//    .frame(maxWidth: .infinity, minHeight: 150)
//    .background(Color.gray.opacity(0.2))
//    .cornerRadius(12)
//  }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


