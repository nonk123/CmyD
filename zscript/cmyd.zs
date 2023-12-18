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

    if (!owner && !owner.player) {
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
    if (weapon) {
        weapon.Destroy();
    }
}

void HideForLocalPlayer() {
    if (owner.player == players[consolePlayer]) {
        weapon.bInvisible = true;
    }
}

void SpawnWeapon(string clazz) {
    if (weapon) {
        weapon.Destroy();
    }

    weapon = Actor.Spawn(clazz, pos);

    weapon.bFlatSprite = true;
    weapon.bRollSprite = true;
    weapon.bForceXYBillboard = false;
    weapon.bForceYBillboard = false;
    weapon.bNoInteraction = true;
    weapon.bRollSprite = true;
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
    float hDir = owner.angle;
    float vDir = owner.pitch;

    float dist = owner.radius + weapon.radius;

    float x = owner.pos.x + Cos(hDir) * dist;
    float y = owner.pos.y + Sin(hDir) * dist;
    float z = owner.pos.z + owner.height * 0.5 - Sin(vDir) * dist;

    weapon.SetXYZ((x, y, z));
    weapon.angle = hDir - 90.0;
    weapon.pitch = 270.0;
    weapon.roll = vDir;
}
