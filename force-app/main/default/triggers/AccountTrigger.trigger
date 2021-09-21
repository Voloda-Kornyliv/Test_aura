trigger AccountTrigger on Account (after delete) {
    new AccountTriggerHandler.run();
}