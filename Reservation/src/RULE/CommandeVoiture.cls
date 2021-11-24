/// 
Class RULE.CommandeVoiture Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="Production.ProductionReservation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="source" value="ServiceFichierVoitureCommande"></constraint>
<constraint name="msgClass" value="msg.creerVoitureDmde"></constraint>
</rule>
<send transform="Transform.transfo.voiture" target="Voiture"></send>
</ruleSet>
</ruleDefinition>
}

}
