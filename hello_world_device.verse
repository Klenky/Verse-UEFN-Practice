
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# A Verse-authored creative device that can be placed in a level
hello_world_device := class(creative_device):

    var PlayerHealth : float = 20.0
    MaxHealth : float = 100.0
    MinHealth : float = 1.0
    PotionDamageAmount : float = 20.0
    PotionHealAmount : float = 10.0
    PlayerStatusText : string = "Player health now "
    var EffectOnPlayerText : string = "damaged "
    var PotionType : string = "damage"


    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        
        # Runs if player hurt by damage potion
        # Checks to prevent player from getting one shotted
        if(PotionType = "damage"):
            if((PlayerHealth > PotionDamageAmount)):
                set PlayerHealth = PlayerHealth - PotionDamageAmount
                Print("The Player was {EffectOnPlayerText + ToString(PotionDamageAmount)}")
                Print("{PlayerStatusText + ToString(PlayerHealth)}")
            else if(PlayerHealth > MinHealth):  #Give player second chance
                set PlayerHealth = MinHealth
                Print("The Player was {EffectOnPlayerText}and narrowly escaped death...")
                Print("{PlayerStatusText + ToString(PlayerHealth)}")
            else:
                set PlayerHealth = 0.0
                Print("Player Eliminated")

        # Runs if player drinks health potion
        # Checks if heal amount would exceed max health ensures
        # it would not exceed that amount
        if(PotionType = "heal"):
            if((PlayerHealth + PotionHealAmount) < MaxHealth):
                set PlayerHealth = PlayerHealth + PotionHealAmount
                set EffectOnPlayerText = "healed "
                Print("The Player was {EffectOnPlayerText + ToString(PotionHealAmount)}")
                Print("{PlayerStatusText + ToString(PlayerHealth)}")
            else:
                set PlayerHealth = MaxHealth
                Print("{PlayerStatusText}at max health")
        
        