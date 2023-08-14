class X2EventListener_WAR extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Create_ListenerTemplate());

	return Templates;
}

static function CHEventListenerTemplate Create_ListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'X2EventListener_WOTCWeaponAnimationsRepository');

	Template.RegisterInTactical = false;
	Template.RegisterInStrategy = true;

	Template.AddCHEvent('OverrideShowItemInLockerList', OnOverrideShowItemInLockerList, ELD_Immediate);

	return Template;
}

static private function EventListenerReturn OnOverrideShowItemInLockerList(Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData)
{
	local XComGameState_Item		ItemState;
	local XComLWTuple				Tuple;
	local EInventorySlot			Slot;
	local X2WeaponTemplate			WeaponTemplate;
	local XComGameState_Unit		UnitState;
	local X2SoldierClassTemplate	SoldierClassTemplate;	
	
	Tuple = XComLWTuple(EventData);
	Slot = EInventorySlot(Tuple.Data[1].i);

	UnitState = XComGameState_Unit(Tuple.Data[2].o);
	if (UnitState == none)
		return ELR_NoInterrupt;

	ItemState = XComGameState_Item(EventSource);
	if (ItemState == none)
		return ELR_NoInterrupt;
		
	WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
	if (WeaponTemplate == none)
		return ELR_NoInterrupt;
	
	SoldierClassTemplate = UnitState.GetSoldierClassTemplate();
	if (SoldierClassTemplate != none && SoldierClassTemplate.IsWeaponAllowedByClass_CH(WeaponTemplate, Slot))
	{
		Tuple.Data[0].b = true;
	}

	return ELR_NoInterrupt;
}

