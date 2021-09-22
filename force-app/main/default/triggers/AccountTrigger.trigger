trigger AccountTrigger on Account (before delete) {
    new AccountTriggerHandler().run();
}