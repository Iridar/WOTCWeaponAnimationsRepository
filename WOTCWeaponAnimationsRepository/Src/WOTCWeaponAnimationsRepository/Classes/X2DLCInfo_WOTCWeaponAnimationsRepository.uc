class X2DLCInfo_WOTCWeaponAnimationsRepository extends X2DownloadableContentInfo;

static function UpdateAnimations(out array<AnimSet> CustomAnimSets, XComGameState_Unit UnitState, XComUnitPawn Pawn)
{
	local XComGameState_Item ItemState;

	ItemState = UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
	if (ItemState != none && ItemState.GetWeaponCategory() == 'pistol')
	{
		CustomAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("IRITestPackage.Anim.AS_Soldier")));
	}
}
