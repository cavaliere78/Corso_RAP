@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZR_BIGLIETTO_SS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_BIGLIETTO_SS as select from zbiglietto_ss
//composition of target_data_source_name as _association_name
{
    key zid as Zid,
@Semantics.user.createdBy: true   
    zcre_user as ZcreUser,
@Semantics.systemDateTime.createdAt: true    
    zcre_ts as ZcreTs,
@Semantics.user.lastChangedBy: true
    zmod_user as ZmodUser,
@Semantics.systemDateTime.lastChangedAt: true    
    zmod_ts as ZmodTs
//    _association_name // Make association public
}
