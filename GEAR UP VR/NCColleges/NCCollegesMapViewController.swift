//
//  NCCollegesMap_ViewController.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 07/02/20.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import MapKit
import UIKit

class NCCollegesMapViewController: NCCollegesListViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView?
    var userClickHappened: Bool = false
    var annotations: MKAnnotation?
    var selectedAnnotation: MKAnnotation?
    var ignoreLocation: Bool = false
    let locationManager = CLLocationManager()

    ///  This method is to initialize map view controller with list of colleges
    override init() {
        super.init()
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: tableview.frame.size.width, height: 200))
        mapView?.showsBuildings = true
        mapView?.setNeedsLayout()
        tableview.sectionHeaderHeight = (mapView?.frame.size.height)!
        mapView?.delegate = self

        let locationButton = UIButton(type: .roundedRect)
        locationButton.setImage(UIImage(named: "gps_user"), for: .normal)
        locationButton.frame = CGRect(x: (mapView?.frame.width ?? 20) - (40 + 10),
                                      y: 10,
                                      width: 40,
                                      height: 40)
        if #available(iOS 13.0, *) {
            locationButton.tintColor = UIColor.label
            locationButton.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.80)
        } else {
            // Fallback on earlier versions
            locationButton.tintColor = UIColor.darkText
            locationButton.backgroundColor = UIColor.white.withAlphaComponent(0.80)
        }
        locationButton.layer.cornerRadius = 5.0
        locationButton.layer.shadowColor = UIColor.darkGray.cgColor
        locationButton.layer.shadowRadius = 5
        locationButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        locationButton.layer.shadowOpacity = 0.50
        locationButton.addTarget(self,
                                 action: #selector(NCCollegesMapViewController.focusToUserLocation),
                                 for: .touchUpInside)

        mapView?.addSubview(locationButton)

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        ignoreLocation = true
        super.viewWillAppear(animated)
    }

    /// This method is to setup map with annotations
    func reloadAnnotations() {
        mapView?.removeAnnotations(mapView?.annotations ?? [])

        collegeList?.forEach { college in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: college.location.latitude,
                                                           longitude: college.location.longitude)
            annotation.title = college.name
            self.mapView?.addAnnotation(annotation)
        }

        userClickHappened = true
        if let annotations = mapView?.annotations {
            mapView?.showAnnotations(annotations, animated: true)
        }
    }

    func fitMapForSelectedAnnotation() {
        userClickHappened = true
        if let selectedAnnotation = self.selectedAnnotation {
            let region = MKCoordinateRegion(center: selectedAnnotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            guard CLLocationCoordinate2DIsValid(region.center) else {
                return
            }
            mapView?.setRegion(region, animated: true)
        }
    }

    func fitMapForAllAnnotation() {
        userClickHappened = true
        let coordinatesArray = collegeList?.map { $0.location }
        var zoomRect = MKMapRect.null

        coordinatesArray?.forEach { coordinate in
            let annotationPoint = MKMapPoint(CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                    longitude: coordinate.longitude))

            let pointRect = MKMapRect(x: annotationPoint.x,
                                      y: annotationPoint.y,
                                      width: 0.1,
                                      height: 0.1)

            zoomRect = zoomRect.union(pointRect)
        }

        let region = MKCoordinateRegion(zoomRect)
        guard CLLocationCoordinate2DIsValid(region.center) else {
            return
        }
        mapView?.setRegion(region, animated: false)
    }

    override func loadData(loadMore: Bool) {
        var northEastCoordinate: CLLocationCoordinate2D?
        var southWestCoordinate: CLLocationCoordinate2D?

        if !ignoreLocation, !NCCollegeService.shared.shouldRealodList {
            northEastCoordinate = mapView?.northEastCoordinate
            southWestCoordinate = mapView?.southWestCoordinate
        }
        ignoreLocation = false

        if isBusy {
            return
        }

        isBusy = true

        NCCollegeService.shared.fetchListOfColleges(northEastCoordinate: northEastCoordinate,
                                                    southWestCoordinate: southWestCoordinate,
                                                    loadMore: loadMore) { colleges, error in
            self.serviceCompletionHandler?(colleges, loadMore, error)
            self.reloadAnnotations()
        }
    }

    @objc func handleAccessoryButton(sender: UIButton) {
        if let uid = collegeList?[sender.tag].uid {
            let detailViewcontroller = CollegeDetailViewController()
            detailViewcontroller.universityID = uid
            navigationController?.pushViewController(detailViewcontroller, animated: true)
        }
    }

    @objc func focusToUserLocation() {
        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        // Zoom to user location
        mapViewSetRegion(centerCoordinate: locationManager.location?.coordinate)
    }

    /// Zoom map to location
    /// - Parameter centerCoordinate: center coordinate for the zoom location
    func mapViewSetRegion(centerCoordinate _: CLLocationCoordinate2D?) {
        if let location = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: location,
                                                span: MKCoordinateSpan(latitudeDelta: 2,
                                                                       longitudeDelta: 2))
            mapView?.setRegion(viewRegion, animated: true)
        }
    }

    // MARK: - Tableview Datasource methods

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        return mapView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if cell is NCCollegesListTableViewCell {
            let accessoryButton = UIButton(type: .custom)
            accessoryButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
            accessoryButton.setImage(UIImage.mapViewAccessoryButtonImage, for: .normal)
            accessoryButton.addTarget(self, action: #selector(handleAccessoryButton(sender:)), for: .touchUpInside)
            accessoryButton.tag = indexPath.row
            cell.accessoryView = accessoryButton
        }

        return cell
    }

    // MARK: Tableview Delegate methods

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let college = collegeList?[indexPath.row],
            let annotations = mapView?.annotations {
			for annotation in annotations
				where annotation.coordinate.latitude == college.location.latitude &&
					annotation.coordinate.longitude == college.location.longitude {
						userClickHappened = true
						mapView?.selectAnnotation(annotation, animated: true)
						selectedAnnotation = annotation

						UIView.animate(withDuration: 5.0,
									   animations: {
										self.fitMapForAllAnnotation()
						}, completion: { _ in
							self.fitMapForSelectedAnnotation()
						})
            }
        }
    }

    // MARK: - Location manager delegate

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            // Zoom to user location
            mapViewSetRegion(centerCoordinate: locationManager.location?.coordinate)
        }
    }

    // MARK: - MapView Delegate methods

    func mapView(_: MKMapView, regionDidChangeAnimated _: Bool) {
        if userClickHappened == true {
            userClickHappened = false
            return
        }

        showActivityIndicator()
        loadData(loadMore: false)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MapAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = false
            annotationView?.isEnabled = false
        } else {
            annotationView!.annotation = annotation
        }
        annotationView!.image = UIImage.mapViewmarkerImage
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage(named: "ic_place_selected")

        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: mapView.region.span)
        mapView.setRegion(region, animated: false)
    }

    func mapView(_: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage.mapViewmarkerImage
    }
}

extension MKMapView {
    var northEastCoordinate: CLLocationCoordinate2D {
        let northEastPoint = CGPoint(x: bounds.origin.x + bounds.size.width, y: bounds.origin.y)
        return convert(northEastPoint, toCoordinateFrom: self)
    }

    var southWestCoordinate: CLLocationCoordinate2D {
        let southWestPoint = CGPoint(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height)
        return convert(southWestPoint, toCoordinateFrom: self)
    }
}
