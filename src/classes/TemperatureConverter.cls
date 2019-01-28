/**
 * Created by lakshmip on 12/4/2018.
 */

public with sharing class TemperatureConverter {

    // Takes a Fahrenheit temperature and returns the Celsius equivalent.
    public static Decimal FarenheittoCelsius(Decimal fh){
        Decimal cs = (fh - 32)* 5/9;
        return cs.setScale(2);
    }

}