/**
 * Created by lakshmip on 12/4/2018.
 */

trigger HelloWorldTrigger on Account (before insert)
{
    //System.debug('Hello world');
    for(Account acct : Trigger.new){
        acct.Description = 'New Description';
    }
}