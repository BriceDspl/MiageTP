Class msg.commandeVoitureDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property marque As %String;

Property model As %String;

Property couleur As %String;

Storage Default
{
<Data name="commandeVoitureDmdeDefaultData">
<Subscript>"commandeVoitureDmde"</Subscript>
<Value name="1">
<Value>marque</Value>
</Value>
<Value name="2">
<Value>model</Value>
</Value>
<Value name="3">
<Value>couleur</Value>
</Value>
</Data>
<DefaultData>commandeVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
