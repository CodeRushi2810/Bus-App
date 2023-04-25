({ 
    showModal : function(component, event, helper) {
    $A.util.removeClass(component.find('popUpId'), 'hideContent');
    $A.util.removeClass(component.find('popUpBackgroundId'), 'hideContent');
},
  
  hidePopup : function(component){
      $A.util.addClass(component.find('popUpId'), 'hideContent');
      $A.util.addClass(component.find('popUpBackgroundId'), 'hideContent');
  },
  handleClick : function(component, event, helper) {
      var Firstname=component.get("v.inp1");
      var Lastname=component.get("v.inp2");
      var Country=component.get("v.inp3");
      var Address1=component.get("v.inp4");
      var Address2=component.get("v.inp5");
      var City=component.get("v.inp6");
      var State=component.get("v.inp7");
      var Zipcode=component.get("v.inp8");
      var Cardno=component.get("v.inp9");
      var Cardtype=component.get("v.inp10");
      var Cvv=component.get("v.inp11");
      var Expirymonth=component.get("v.inp12");
      var Expiryyear=component.get("v.inp13");
      var Payer=component.get("v.inp14");
      var Amount=component.get("v.inp15");
      var action = component.get("c.doDirectPayment");
        action.setParams({
            'fname':Firstname,
            'lastname':Lastname,
            'contry':Country,
            'add1':Address1,
            'add2':Address2,
            'shippingcity':City,
            'shippingstate':State,
            'zip':Zipcode,
            'cardnumber':Cardno,
            'cardtype':Cardtype,
            'cvvno':Cvv,
            'expmonth':Expirymonth,
            'expyear':Expiryyear,
            'pay':Payer,
            'amt':Amount
            
        });
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                alert(a.getReturnValue()); 
            }
        });
        
        $A.enqueueAction(action);
   
    }
 })