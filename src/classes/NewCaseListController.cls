/**
 * Created by lakshmip on 12/5/2018.
 */

public class NewCaseListController {

    public List<Case> getNewCases(){

        List<Case> results = Database.query (
                'SELECT  Id, CaseNumber, Status' +
                        ' FROM Case ' +
                        ' WHERE Status = \'New\''
        );
    return results;
    }

}