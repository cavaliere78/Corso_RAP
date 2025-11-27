@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGLIETTO_SS2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO_SS2
  provider contract transactional_query
  as projection on ZR_BIGLIETTO_SS2
  association [1..1] to ZR_BIGLIETTO_SS2 as _BaseEntity on $projection.Zid = _BaseEntity.Zid
{
  key Zid,
  @Semantics: {
    user.createdBy: true
  }
  Stato,
  ZcreUser,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  ZcreTs,
  @Semantics: {
    user.lastChangedBy: true
  }
  ZmodUser,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ZmodTs,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}
