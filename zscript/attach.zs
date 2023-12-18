class AttachTheD : EventHandler;

override void WorldThingSpawned(WorldEvent ev) {
    if (ev.thing.player) {
        ev.thing.GiveInventoryType("CmyD");
    }
}

override void WorldThingDestroyed(WorldEvent ev) {
    if (ev.thing.GetClassName() == "CmyD") {
        CmyD(ev.thing).Cleanup();
    }
}
