@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBIGLIETTO_SS2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BIGLIETTO_SS2
  as select from zbiglietto_ss2 as Biglietto
{
  key zid as Zid,
  @Semantics.user.createdBy: true
  zcre_user as ZcreUser,
  stato as Stato,
  @Semantics.systemDateTime.createdAt: true
  zcre_ts as ZcreTs,
  @Semantics.user.lastChangedBy: true
  zmod_user as ZmodUser,
  @Semantics.systemDateTime.lastChangedAt: true
  zmod_ts as ZmodTs,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
