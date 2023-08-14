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

static function MatineeGetPawnFromSaveData(XComUnitPawn UnitPawn, XComGameState_Unit UnitState, XComGameState SearchState)
{
    class'ShellMapMatinee'.static.PatchAllLoadedMatinees(UnitPawn, UnitState, SearchState);
}


static function FinalizeUnitAbilitiesForInit(XComGameState_Unit UnitState, out array<AbilitySetupData> SetupData, optional XComGameState StartState, optional XComGameState_Player PlayerState, optional bool bMultiplayerDisplay)
{
	local X2AbilityTemplateManager	AbilityManager;
	local X2AbilityTemplate			Template;
	local AbilitySetupData			ExtraSetupData;
	local XComGameState_Item		PrimaryWeaponState;

	PrimaryWeaponState = UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
	if (UnitState.GetSoldierClassTemplateName() == 'Ranger' && PrimaryWeaponState != none && PrimaryWeaponState.GetWeaponCategory() == 'pistol')
	{
		Template = AbilityManager.FindAbilityTemplate('PistolStandardShot');
		if (Template != none)
		{
			ExtraSetupData.TemplateName = 'PistolStandardShot';
			ExtraSetupData.Template = Template;
			ExtraSetupData.SourceWeaponRef = PrimaryWeaponState.GetReference();
			SetupData.AddItem(ExtraSetupData);
		}
	}
}


static function WeaponInitialized(XGWeapon WeaponArchetype, XComWeapon Weapon, optional XComGameState_Item InternalWeaponState = none)
{
	Local XComGameState_Item	ItemState;
	local XComGameStateHistory	History;
	local XComGameState_Unit	UnitState;

	History = `XCOMHISTORY;
	if (InternalWeaponState == none)
	{
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(WeaponArchetype.ObjectID));
		if (ItemState == none)
			return;
	}
	else
	{
		ItemState = InternalWeaponState;
	}

	if (ItemState.InventorySlot == eInvSlot_PrimaryWeapon && ItemState.GetWeaponCategory() == 'pistol')
	{
		Weapon.DefaultSocket = 'R_Hand';
	}
}
