@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCOMPONENTI_SS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZR_COMPONENTI_SS
  as select from zcomponenti_ss 
  association to parent ZR_BIGLIETTO_SS2 as _Biglietto
  on _Biglietto.Zid = $projection.Zid
{
  key zid as Zid,
  key progressivo as Progressivo,
  tipo_utente as TipoUtente,
  @Semantics.user.createdBy: true
  zcre_user as ZcreUser,
  @Semantics.systemDateTime.createdAt: true
  zcre_ts as ZcreTs,
  @Semantics.user.lastChangedBy: true
  zmod_user as ZmodUser,
  @Semantics.systemDateTime.lastChangedAt: true
  zmod_ts as ZmodTs,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  
  _Biglietto
}
