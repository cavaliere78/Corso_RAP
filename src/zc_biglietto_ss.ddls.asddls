@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Biglietti'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_BIGLIETTO_SS
  provider contract transactional_query as projection on ZR_BIGLIETTO_SS
{
    key Zid,
    ZcreUser,
    ZcreTs,
    ZmodUser,
    ZmodTs
}
