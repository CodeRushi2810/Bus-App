public class SF_FutureMethod {
    
    @future(callout=true)
    public static void myMethod(Decimal euro) {
        Decimal inr;

        HTTP h = new HTTP();
        HTTPRequest req = new HttpRequest();

        req.setEndpoint('https://api.exchangeratesapi.io/latest');
        req.setMethod('GET');

        HTTPResponse res = h.send(req);

        Map<String, Object> jsonBody = (Map<String,Object>)Json.deserializeUntyped(res.getBody());

        Map<String,Object> mMap = (Map<String,Object>) jsonBody.get('rates');

        Decimal conversionRate = (Decimal) mMap.get('INR');

        inr = euro*conversionRate;

        system.debug(euro+' Euros are equal to '+inr+' Rs');
    }
}