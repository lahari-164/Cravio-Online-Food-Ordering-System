/* ==========================================================================
   CRAVIO INDIAN DELIVERY PARTNERS & LIVE TRACKING ENGINE DATA
   15 Authentic Indian Delivery Partners with Phone, Bike Number & Photo
   ========================================================================== */

(function () {
  'use strict';

  const DELIVERY_PARTNERS = [
    { id: 1, name: "Rahul Sharma", phone: "+91 98765 43210", bikeNumber: "TS-09-EA-4587", rating: 4.9, reviewCount: 450, photo: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80", currentLocation: "Jubilee Hills Road 36", status: "Out for Delivery" },
    { id: 2, name: "Suresh Kumar", phone: "+91 98123 45678", bikeNumber: "MH-04-AB-1234", rating: 4.8, reviewCount: 380, photo: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80", currentLocation: "Bandra West Hill Road", status: "Active" },
    { id: 3, name: "Vikram Singh", phone: "+91 98987 65432", bikeNumber: "DL-03-CD-5678", rating: 4.9, reviewCount: 510, photo: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80", currentLocation: "Connaught Place Circle", status: "Active" },
    { id: 4, name: "Rajesh Verma", phone: "+91 97654 32109", bikeNumber: "KA-05-JK-9912", rating: 4.8, reviewCount: 290, photo: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=200&q=80", currentLocation: "Indiranagar 100ft Road", status: "Active" },
    { id: 5, name: "Amit Patel", phone: "+91 96543 21098", bikeNumber: "GJ-01-XY-3456", rating: 4.9, reviewCount: 410, photo: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=200&q=80", currentLocation: "CG Road Satellite", status: "Active" },
    { id: 6, name: "Deepanshu Malhotra", phone: "+91 95432 10987", bikeNumber: "HR-26-DQ-8811", rating: 4.7, reviewCount: 320, photo: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=80", currentLocation: "Cyber City Gurgaon", status: "Active" },
    { id: 7, name: "Manoj Kumar", phone: "+91 94321 09876", bikeNumber: "UP-32-BZ-7744", rating: 4.8, reviewCount: 260, photo: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=200&q=80", currentLocation: "Hazratganj Main", status: "Active" },
    { id: 8, name: "Harpreet Singh", phone: "+91 93210 98765", bikeNumber: "PB-65-AK-2233", rating: 4.9, reviewCount: 480, photo: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=200&q=80", currentLocation: "Model Town", status: "Active" },
    { id: 9, name: "Ganesh Rao", phone: "+91 92109 87654", bikeNumber: "AP-28-BM-1199", rating: 4.8, reviewCount: 340, photo: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80", currentLocation: "Beach Road Vizag", status: "Active" },
    { id: 10, name: "Ramesh Nair", phone: "+91 91098 76543", bikeNumber: "KL-07-CC-5522", rating: 4.9, reviewCount: 430, photo: "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?auto=format&fit=crop&w=200&q=80", currentLocation: "MG Road Kochi", status: "Active" },
    { id: 11, name: "Sunil Deshmukh", phone: "+91 90987 65432", bikeNumber: "MH-12-PQ-6633", rating: 4.8, reviewCount: 310, photo: "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=200&q=80", currentLocation: "Koregaon Park Pune", status: "Active" },
    { id: 12, name: "Ajay Yadav", phone: "+91 98876 54321", bikeNumber: "RJ-14-SK-4488", rating: 4.7, reviewCount: 220, photo: "https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=200&q=80", currentLocation: "C Scheme Jaipur", status: "Active" },
    { id: 13, name: "Prakash Joshi", phone: "+91 97765 43210", bikeNumber: "MP-04-TR-9900", rating: 4.9, reviewCount: 390, photo: "https://images.unsplash.com/photo-1463453091185-61582044d556?auto=format&fit=crop&w=200&q=80", currentLocation: "Palasia Indore", status: "Active" },
    { id: 14, name: "Santosh Reddy", phone: "+91 96654 32109", bikeNumber: "TS-10-EH-3311", rating: 4.8, reviewCount: 370, photo: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80", currentLocation: "Banjara Hills Hyderabad", status: "Active" },
    { id: 15, name: "Vijay Anand", phone: "+91 95543 21098", bikeNumber: "TN-09-BU-7722", rating: 4.9, reviewCount: 540, photo: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80", currentLocation: "T Nagar Chennai", status: "Active" }
  ];

  window.CravioDelivery = {
    PARTNERS: DELIVERY_PARTNERS,
    getRandomPartner: function() {
      const idx = Math.floor(Math.random() * DELIVERY_PARTNERS.length);
      return DELIVERY_PARTNERS[idx];
    }
  };
})();
