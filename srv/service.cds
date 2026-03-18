using { asset.master as assets } from '../db/schema';

service AssetService @(path:'CatalogService') {

    entity FavoriteSearch           as projection on assets.FAVORITE_SEARCH;

    entity Inventory                as projection on assets.INVENTORY;
    entity InventoryPosition        as projection on assets.INVENTORY_POSITION;

    entity OrderNotification        as projection on assets.ORDER_NOTIFICATION;

    entity PicklistEquipment        as projection on assets.PICKLIST_EQUIPEMENT;
    entity PicklistLocation         as projection on assets.PICKLIST_LOCATION;
    entity PicklistMaterial         as projection on assets.PICKLIST_MATERIAL;
    entity PicklistWorkcenter       as projection on assets.PICKLIST_WORKCENTER;
    entity Picklists                as projection on assets.PICKLISTS;

    entity PlantsManagement         as projection on assets.PLANTS_MANAGEMENT;

    entity User                     as projection on assets.USER;
    entity UserArticle              as projection on assets.USER_ARTICLE;
    entity UserClass                as projection on assets.USER_CLASS;
    entity UserEquipment            as projection on assets.USER_EQUIPMENT;
    entity UserFunctionalLocation   as projection on assets.USER_FUNCTIONAL_LOCATION;
    entity UserGroup                as projection on assets.USER_GROUP;
    entity UserGroups               as projection on assets.USER_GROUPS;
    entity UserPlants               as projection on assets.USER_PLANTS;
    entity UserPrinter              as projection on assets.USER_PRINTER;
    entity UserWorkcenter           as projection on assets.USER_WORKCENTER;

    type LoginResponse {
    login        : Boolean;
    userID       : String;
    name         : String;
    user         : String;
    email        : String;
    phone        : String;
    language     : String;
    firstname    : String;
    lastname     : String;
    jobfunction  : String;
    groupfunction: String;
    plant        : String;
    article      : String;
    workshift    : String;
    logDate      : Timestamp;
}

    action LoginOp(USERNAME :String, PASSWORD :String) returns LoginResponse;



}