// trigger updateSeatBackgroundColor on Bus_Itinerary_Seat__c (before update) {
//     for (Bus_Itinerary_Seat__c seat : Trigger.new) {
//         if (seat.Status__c != Trigger.oldMap.get(seat.Id).Status__c) {
//             if (seat.Status__c == 'Booked') {
//                 seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #db5d47, #a81900);';
//             } else if (seat.Status__c == 'Available') {
//                 seat.Seat_Bg_Color__c = 'border: 1px solid #05060e ; background: #EFEFEF;';
//             } else if (seat.Status__c == 'Not Available') {
//                 seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #68737c, #22262e);';
//             }
//         }
//     }
// }

trigger updateSeatBackgroundColor on Bus_Itinerary_Seat__c (before update, before insert) {
    for (Bus_Itinerary_Seat__c seat : Trigger.new) {
        if (Trigger.isUpdate && seat.Status__c != Trigger.oldMap.get(seat.Id).Status__c) {
            // Update logic for existing records
            if (seat.Status__c == 'Booked') {
                seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #db5d47, #a81900);';
            } else if (seat.Status__c == 'Available') {
                seat.Seat_Bg_Color__c = 'border: 1px solid #05060e ; background: #EFEFEF;';
            } else if (seat.Status__c == 'Not Available') {
                seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #68737c, #22262e);';
            }
        } else {
            // Update logic for new records
            if (seat.Status__c == 'Booked') {
                seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #db5d47, #a81900);';
            } else if (seat.Status__c == 'Available') {
                seat.Seat_Bg_Color__c = 'border: 1px solid #05060e ; background: #EFEFEF;';
            } else if (seat.Status__c == 'Not Available') {
                seat.Seat_Bg_Color__c = 'border: none ; background: linear-gradient(93deg, #68737c, #22262e);';
            }
        }
    }
}
