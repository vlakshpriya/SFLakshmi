/**
 * Created by lakshmip on 12/4/2018.
 */

@IsTest
private class TestVerifyDate {
    @IsTest
    static void testWithin30Days() {
        Date date1 = System.today();
        Date date2 = System.today().addDays(5);
        Date dt1 = VerifyDate.CheckDates(date1,date2);
        System.assertEquals(date2,dt1);
    }
    @IsTest
    static void testOutside30days() {
        Date date1 = System.today();
        Date date2 = System.today().addDays(20);
        Date dt2 = VerifyDate.CheckDates(date1,date2);
        System.assertEquals(date1,dt2);
    }
}