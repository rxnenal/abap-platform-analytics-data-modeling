@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier Hierarchy Nodes (tim-dep)'
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'Nodename'
@ObjectModel: {
  supportedCapabilities: [ #ANALYTICAL_DIMENSION ],
  modelingPattern: #ANALYTICAL_DIMENSION
}
define view entity ZNER_ANA_I_CARRHIERNODE_TD 
as select from zner_ana_cr_t_hn
  association to ZNER_ANA_I_CARRIERHIERDIR_TD as _Dir on  _Dir.HierarchyID = $projection.HierarchyID
                                                      and _Dir.DateTo      = $projection.DateTo
{
       @ObjectModel.foreignKey.association: '_Dir'
   key hierarchy_id  as HierarchyID,
       @ObjectModel.text.element: [ 'NodeText' ]
   key nodename as NodeName,
       @Semantics.businessDate.to: true
   key date_to       as DateTo,   
       @Semantics.businessDate.from: true
       date_from     as DateFrom,   
       @Semantics.text: true
       nodetext      as NodeText,
       
   _Dir
}
