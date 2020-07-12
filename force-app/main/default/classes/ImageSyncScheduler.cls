global class ImageSyncScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        ImageSyncUtils.startSync();
    }
}
