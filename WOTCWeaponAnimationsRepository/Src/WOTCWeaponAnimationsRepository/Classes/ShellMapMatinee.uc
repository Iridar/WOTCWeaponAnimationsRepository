class ShellMapMatinee extends Object;

var string AnimSequencePrefix;
var string PatchAnimsetPath;

static function PatchAllLoadedMatinees(XComUnitPawn UnitPawn, XComGameState_Unit UnitState, XComGameState SearchState)
{
	local array<SequenceObject> FoundMatinees;
	local array<string> PackageNames;
	local SequenceObject MatineeObject;
	local Sequence GameSeq;
 
	GameSeq = class'WorldInfo'.static.GetWorldInfo().GetGameSequence();
	GameSeq.FindSeqObjectsByClass(class'SeqAct_Interp', true, FoundMatinees);
 
	foreach FoundMatinees(MatineeObject)
	{
		ParseStringIntoArray(PathName(MatineeObject), PackageNames, ".", true);

		if (MatineeObject.ObjComment == "XCOMSoldier" || MatineeObject.ObjComment == "XCOMSoldierPreview")
		{
			//`LOG("Package" @ PackageNames[0] @ MatineeObject.ObjComment,, name("DualWieldPistols" @ default.Class.name));
			PatchSingleMatinee(SeqAct_Interp(MatineeObject), UnitPawn, UnitState, SearchState);
		}
	}
}

static function PatchSingleMatinee(SeqAct_Interp SeqInterp, 
									XComUnitPawn UnitPawn, 
									XComGameState_Unit UnitState, 
									XComGameState SearchState)
{
	local InterpData Data;
	local InterpGroup Group;
	local InterpTrack Track;
	local InterpTrackAnimControl AnimControl;
	local int KeyIndex;
	local array<name> PatchSequenceNames;
	local AnimSet PatchAnimset;
	local AnimSequence Sequence;

	PatchAnimset = AnimSet(`CONTENT.RequestGameArchetype(default.PatchAnimsetPath));

	foreach PatchAnimset.Sequences(Sequence)
	{
		PatchSequenceNames.AddItem(name(Repl(Sequence.SequenceName, default.AnimSequencePrefix, "")));
		//`LOG("Adding sequence " @ name(Repl(Sequence.SequenceName, default.AnimSequencePrefix, "")),, name("DualWieldMelee" @ default.Class.name));
	}

	Data = InterpData(SeqInterp.VariableLinks[0].LinkedVariables[0]);
	
	foreach Data.InterpGroups(Group)
	{
		if (Group.GroupName == 'Burnout')
		{
			if(!class'X2DownloadableContentInfo_DualWieldedPistols'.static.HasDualPistolEquipped(UnitState, SearchState))
			{
				//`LOG(UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon, SearchState) @ UnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, SearchState),, name("DualWieldMelee" @ default.Class.name));
				//`LOG(UnitState.GetFullName() @ "dont has dual melee, skipping patching",, name("DualWieldMelee" @ default.Class.name));
				continue;
			}

			if (Group.GroupAnimSets.Find(PatchAnimset) == INDEX_NONE)
			{
				Group.GroupAnimSets.AddItem(PatchAnimset);
				//`LOG("Add animset" @ PatchAnimset @ "to" @ Group.GroupName @ Group.GroupAnimSets.Length,, name("DualWieldMelee" @ default.Class.name));
			}

			foreach Group.InterpTracks(Track)
			{
				AnimControl = InterpTrackAnimControl(Track);
				if (AnimControl != none)
				{
					for (KeyIndex = 0; KeyIndex < AnimControl.AnimSeqs.Length; KeyIndex++)
					{
						if (PatchSequenceNames.Find(AnimControl.AnimSeqs[KeyIndex].AnimSeqName) != INDEX_NONE)
						{
							//`LOG("Found animsequence" @ Group.GroupName @ AnimControl.AnimSeqs[KeyIndex].AnimSeqName,, name("DualWieldMelee" @ default.Class.name));
							AnimControl.AnimSeqs[KeyIndex].AnimSeqName = name(default.AnimSequencePrefix $ AnimControl.AnimSeqs[KeyIndex].AnimSeqName);
							//`LOG("Patching" @ Group.GroupName @ UnitState.GetFullName() @ AnimControl.AnimSeqs[KeyIndex].AnimSeqName,, name("DualWieldMelee" @ default.Class.name));
						}
						else
						{
							//`LOG("Could NOT find" @ Group.GroupName @ AnimControl.AnimSeqs[KeyIndex].AnimSeqName @ "in patch list",, name("DualWieldMelee" @ default.Class.name));
						}
					}
				}
			}
		}
	}
}

defaultproperties
{
	AnimSequencePrefix="PP_"
	PatchAnimsetPath="ShellDualPistols.Anims.AS_ShellScreenDualPistols"
}