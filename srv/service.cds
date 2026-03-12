using { asset.master as asset } from '../db/schema';

service AssetService @(path:'CatalogService') {

    entity User as projection on asset.User;   

    action LoginOp(USERNAME:String, PASSWORD:String) returns String;

}