@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMPONENTI_SS'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMPONENTI_SS

  as projection on ZR_COMPONENTI_SS
  association [1..1] to ZR_COMPONENTI_SS as _BaseEntity 
  on $projection.Zid = _BaseEntity.Zid 
  and $projection.Progressivo = _BaseEntity.Progressivo
{
  key Zid,
  key Progressivo,
  TipoUtente,
  @Semantics: {
    user.createdBy: true
  }
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

  _BaseEntity,
  _Biglietto : redirected to parent ZC_BIGLIETTO_SS2
}
