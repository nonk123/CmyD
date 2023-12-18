class CmyD : Inventory;

Actor weapon;
string lastWeaponClazz;

Default {
    +Inventory.Quiet
}

override void AttachToOwner(Actor other) {
    super.AttachToOwner(other);
    Tick();
}

override void DetachFromOwner() {
    super.DetachFromOwner();
    Cleanup();
}

override void Tick() {
    super.Tick();

    if (owner == null && owner.player == null) {
        return;
    }

    string clazz = owner.player.readyWeapon.GetClassName();

    if (lastWeaponClazz != clazz) {
        SpawnWeapon(clazz);
    }

    RepositionWeapon();
    HideForLocalPlayer();

    lastWeaponClazz = clazz;
}

void Cleanup() {
    if (weapon != null) {
        weapon.Destroy();
    }
}

void HideForLocalPlayer() {
    if (owner.player == players[consolePlayer]) {
        weapon.bInvisible = true;
    }
}

void SpawnWeapon(string clazz) {
    if (weapon != null) {
        weapon.Destroy();
    }

    weapon = Actor.Spawn(clazz, pos);
    weapon.bNoInteraction = true;
    weapon.bWallSprite = true;
    weapon.bSolid = false;
    weapon.bShootable = false;
    weapon.bNoGravity = true;
    weapon.bPushable = false;
    weapon.bSlidesOnWalls = false;
    weapon.bNoTrigger = true;
    weapon.bNoTelestomp = true;
    weapon.bCannotPush = true;
    weapon.bNoDamage = true;
}

void RepositionWeapon() {
    float dir = owner.angle;
    float dist = owner.radius + weapon.radius;

    float x = owner.pos.x + Cos(dir) * dist;
    float y = owner.pos.y + Sin(dir) * dist;
    float z = owner.pos.z + owner.height * 0.5;

    weapon.SetXYZ((x, y, z));
    weapon.angle = dir - 90.0;
}
