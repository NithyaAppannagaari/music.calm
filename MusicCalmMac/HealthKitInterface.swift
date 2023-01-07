import Foundation
 
// STEP 1: MUST import HealthKit
import HealthKit
import WatchConnectivity
import UIKit
 
@available(iOS 13.0, *)
class HealthKitInterface
{
   // public let healthStore = HKHealthStore()
    var tot = 200
    var count = 0
    
   /*private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
        
        var validSession: WCSession? {
            
            // Adapted from https://gist.github.com/NatashaTheRobot/6bcbe79afd7e9572edf6
            
            #if os(iOS)
                if let session = session, session.isPaired && session.isWatchAppInstalled {
                    return session
                }
            #elseif os(watchOS)
                return session
            #endif
            return nil
        }*/
    // STEP 2: a placeholder for a conduit to all HealthKit data
    //    let healthKitDataStore: HKHealthStore?
    
    // STEP 3: create member properties that we'll use to ask
    // if we can read and write heart rate data
    /*  let readableHKQuantityTypes: Set<HKQuantityType>?
     let writeableHKQuantityTypes: Set<HKQuantityType>?
     
     @available(iOS 13.0, *)
     init(_ home: HomePageViewController) {
     
     // STEP 4: make sure HealthKit is available
     if HKHealthStore.isHealthDataAvailable() {
     
     // STEP 5: create one instance of the HealthKit store
     // per app; it's the conduit to all HealthKit data
     self.healthKitDataStore = HKHealthStore()
     
     let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
     
     // STEP 9.2: define a query for "recent" heart rate data;
     // in pseudo-SQL, this would look like:
     //
     // SELECT bpm FROM HealthKitStore WHERE qtyTypeID = '.heartRate';
     
     // STEP 6: create two Sets of HKQuantityTypes representing
     // heart rate data; one for reading, one for writing
     readableHKQuantityTypes = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
     writeableHKQuantityTypes = [HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
     
     // STEP 7: ask user for permission to read and write
     // heart rate data
     healthKitDataStore?.requestAuthorization(toShare: writeableHKQuantityTypes,
     read: readableHKQuantityTypes,
     completion: { (success, error) -> Void in
     if success {
     print("Successful authorization.")
     } else {
     print(error.debugDescription)
     }
     })
     
     } // end if HKHealthStore.isHealthDataAvailable()
     
     else {
     
     self.healthKitDataStore = nil
     self.readableHKQuantityTypes = nil
     self.writeableHKQuantityTypes = nil
     
     
     
     }
     } // end init()
     
     // STEP 8.0: this is my wrapper for writing one heart
     // rate sample at a time to the HKHealthStore
     func writeHeartRateData( heartRate: Int ) -> Void {
     // STEP 8.1: "Count units are used to represent raw scalar values. They are often used to represent the number of times an event occurs"
     let heartRateCountUnit = HKUnit.count()
     // STEP 8.2: "HealthKit uses quantity objects to store numerical data. When you create a quantity, you provide both the quantity’s value and unit."
     // beats per minute = heart beats / minute
     let beatsPerMinuteQuantity = HKQuantity(unit: heartRateCountUnit.unitDivided(by: HKUnit.minute()), doubleValue: Double(heartRate))
     // STEP 8.3: "HealthKit uses quantity types to create samples that store a numerical value. Use quantity type instances to create quantity samples that you can save in the HealthKit store."
     // Short-hand for HKQuantityTypeIdentifier.heartRate
     let beatsPerMinuteType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
     // STEP 8.4: "you can use a quantity sample to record ... the user's current heart rate..."
     let heartRateSampleData = HKQuantitySample(type: beatsPerMinuteType, quantity: beatsPerMinuteQuantity, start: Date(), end: Date())
     
     // STEP 8.5: "Saves an array of objects to the HealthKit store."
     healthKitDataStore?.save([heartRateSampleData]) { (success: Bool, error: Error?) in
     // print("Heart rate \(heartRate) saved.")
     //  }
     
     } // end func writeHeartRateData
     }
     // STEP 9.0: this is my wrapper for reading all "recent"
     // heart rate samples from the HKHealthStore
     @available(iOS 13.0, *)
     func readHeartRateData() {
     // STEP 9.1: just as in STEP 6, we're telling the `HealthKitStore`
     // that we're interested in reading heart rate data
     let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
     
     // STEP 9.2: define a query for "recent" heart rate data;
     // in pseudo-SQL, this would look like:
     //
     // SELECT bpm FROM HealthKitStore WHERE qtyTypeID = '.heartRate';
     let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) {
     (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
     if let samples = samplesOrNil {
     for heartRateSamples in samples {
     if heartRateSamples is HKQuantitySample
     {
     let value: HKQuantitySample? = heartRateSamples as! HKQuantitySample
     let hrUnit = HKUnit(from: "count/min")
     let heartValue = (value?.quantity.doubleValue(for: hrUnit))!
     heartBeatNums.append(Int(heartValue))
     self.writeHeartRateData(heartRate: Int(heartValue))
     print(Int(heartValue))
     print(heartRateSamples.startDate)
     self.count+=1
     if(self.count>=self.tot){ break }
     //print(Int(heartValue))
     }
     }
     
     } else {
     print("No heart rate sample available.")
     }
     
     }
     
     // STEP 9.3: execute the query for heart rate data
     healthKitDataStore?.execute(query)
     } // end func readHeartRateData*/
    
     let defaultSession = WCSession.default
     
     let healthStore = HKHealthStore()
    
     var currentHeartRateSample : [HKSample]?
     
     var currentHeartLastSample : HKSample?
     
     var currentHeartRateBPM = Double()
    
    init(_ controller: HomePageViewController){
        
    }
     
     
     //Get Heart Rate from Health Kit
     
     func getCurrentHeartRateData(){
        
         let calendar = Calendar.current
         let components = calendar.dateComponents([.year, .month, .day], from: Date())
         let startDate : Date = calendar.date(from: components)!
         let endDate : Date = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate as Date)!
    
         print(startDate)
         print(endDate)
             
         
         
         let sampleType : HKSampleType =  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
         let predicate : NSPredicate =  HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
         let anchor: HKQueryAnchor = HKQueryAnchor(fromValue: 0)
         
         let anchoredQuery = HKAnchoredObjectQuery(type: sampleType, predicate: predicate, anchor: anchor, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error ) in
             
            // print(samples)
         
             if samples != nil {
                self.collectCurrentHeartRateSample(currentSampleTyple: samples!, deleted: deletedObjects!)
            }
         
         }
     
        // anchoredQuery.updateHandler = { (query, samples, deletedObjects, anchor, error) -> Void in
          //   self.collectCurrentHeartRateSample(currentSampleTyple: samples!, deleted: deletedObjects!)
        // }
         
         self.healthStore.execute(anchoredQuery)
     }
     
     
     //Retrived necessary parameter from HK Sample
     func collectCurrentHeartRateSample(currentSampleTyple : [HKSample]?, deleted : [HKDeletedObject]?){
     
         self.currentHeartRateSample = currentSampleTyple
         
         if let currentHeartRateSample = currentSampleTyple {
             let reversed = currentHeartRateSample.reversed()
             for heartRateSamples in reversed {
                 if heartRateSamples is HKDiscreteQuantitySample
                 {
                     let value: HKQuantitySample? = heartRateSamples as! HKQuantitySample
                     let hrUnit = HKUnit(from: "count/min")
                     let heartValue = (value?.quantity.doubleValue(for: hrUnit))!
                     heartBeatNums.append(Int(heartValue))
                     self.count+=1
                     if(self.count>=self.tot){ break }
                 }
             }
         }
         
         //Get Last Sample of Heart Rate
     /*    self.currentHeartLastSample = self.currentHeartRateSample?.last
         
         if self.currentHeartLastSample != nil {
         
             let lastHeartRateSample = self.currentHeartLastSample as! HKQuantitySample
             
             self.currentHeartRateBPM = lastHeartRateSample.quantity.doubleValue(for: HKUnit(from: "count/min"))
             let heartRateStartDate = lastHeartRateSample.startDate
             let heartRateEndDate = lastHeartRateSample.endDate
             heartBeatNum = Int(self.currentHeartRateBPM)
             print(self.currentHeartRateBPM)
            // print(heartRateStartDate)
          //   print(heartRateEndDate)
             //self.currentHeartRateSample?.removeLast()
            // currentSampleTyple?.removeLast()*/
     }
     
     
}
    
   /* func getCurrentHeartRateData()
     {
         self.session(WCSession.default, didReceiveMessage: ["Heart Rate": HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)])
     }
     
     func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
             if let heartRate = message["Heart Rate"] {
                 print("Received heart rate: \(heartRate)")
             } else {
                 print("Did not receive heart rate =[")
             }
     }
    */
    
    //} // end class HealthKitInterface
    
    /*func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let infoToRead = Set([
                HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
                HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
                HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                HKSampleType.quantityType(forIdentifier: .heartRate)!,
                HKSampleType.workoutType()
            ])
            let infoToWrite = Set([
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                HKObjectType.workoutType()
            ])
            
            
            
            healthStore.requestAuthorization(toShare: infoToWrite,
                                             read: infoToRead,
                                             completion: { (success, error) in
                self.delegate?.workout(manager: self,
                                       didAuthorizeAccess: success,
                                       error: error)
                
            })
        }
        
    }
    
    func observerHeartRateSamples() {
          let heartRateSampleType = HKObjectType.quantityType(forIdentifier: .heartRate)
          
          if let observerQuery = observerQuery {
              healthStore.stop(observerQuery)
          }
          
          observerQuery = HKObserverQuery(sampleType: heartRateSampleType!, predicate: nil) { (_, _, error) in
              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  return
              }
              
              self.fetchLatestHeartRateSample { (sample) in
                  guard let sample = sample else {
                      return
                  }
                  
                  DispatchQueue.main.async {
                      let heartRate = sample.quantity.doubleValue(for: self.heartRateUnit)
                      print("Heart Rate Sample: \(heartRate)")
                      self.updateHeartRate(heartRateValue: heartRate)
                  }
              }
          }
          
          healthStore.execute(observerQuery)
      }
      
      func fetchLatestHeartRateSample(completionHandler: @escaping (_ sample: HKQuantitySample?) -> Void) {
          guard let sampleType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else {
              completionHandler(nil)
              return
          }
          
          let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
          let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
          let query = HKSampleQuery(sampleType: sampleType,
                                    predicate: predicate,
                                    limit: Int(HKObjectQueryNoLimit),
                                    sortDescriptors: [sortDescriptor]) { (_, results, error) in
                                      if let error = error {
                                          print("Error: \(error.localizedDescription)")
                                          return
                                      }
                                      
                                      completionHandler(results?[0] as? HKQuantitySample)
          }
          
          healthStore.execute(query)
      }
    
    func startQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            let datePredicate = HKQuery.predicateForSamples(withStart: workoutStartDate, end: nil, options: .strictStartDate)
            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
            let queryPredicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate, devicePredicate])
            
            let updateHandler: ((HKAnchoredObjectQuery, [HKSample]?,
                [HKDeletedObject]?,
                HKQueryAnchor?,
                Error?) -> Void) = { query,
                samples,
                deletedObjects,
                queryAnchor,
                error in
                self.process(samples: samples, quantityTypeIdentifier: quantityTypeIdentifier)
            }
            
            let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!,
                                              predicate: queryPredicate,
                                              anchor: nil,
                                              limit: HKObjectQueryNoLimit,
                                              resultsHandler: updateHandler)
            query.updateHandler = updateHandler
            healthStore.execute(query)
            
            activeDataQueries.append(query)
        }*/

    

