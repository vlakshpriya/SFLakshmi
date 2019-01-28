/**
 * Created by lakshmip on 12/6/2018.
 */
@IsTest
private class AnimalLocatorTest {
    @IsTest static void AnimalLocatorMock1(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(1);
        String expectedResult = 'chicken';
        System.assertEquals(result, expectedResult);
    }

}