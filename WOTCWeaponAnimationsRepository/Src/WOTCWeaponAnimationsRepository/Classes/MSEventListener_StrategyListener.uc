class MSEventListener_StrategyListener extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListenerTemplate());

	return Templates;
}

static function MSEventListenerTemplate CreateListenerTemplate()
{
	local MSEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'MSEventListenerTemplate', Template, 'DualWieldPistolsDummy');
	Template.RegisterInTactical = true;

	return Template;
}
